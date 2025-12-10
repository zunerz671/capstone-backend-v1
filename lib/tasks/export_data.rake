namespace :db do
  desc "Export all data to JSON for migration to PostgreSQL"
  task export_to_json: :environment do
    require "json"

    data = {}

    # Export in the correct order to handle foreign key dependencies
    models = [ User, Lesson, LessonPage, Assessment, Question, AssessmentAttempt, QuestionResponse ]

    models.each do |model|
      table_name = model.table_name
      records = model.all.map(&:attributes)
      data[table_name] = records
      puts "Exported #{records.count} #{table_name}"
    end

    export_path = Rails.root.join("db", "data_export.json")
    File.write(export_path, JSON.pretty_generate(data))
    puts "\n✅ Data exported to #{export_path}"
  end

  desc "Import data from JSON after PostgreSQL migration"
  task import_from_json: :environment do
    require "json"

    export_path = Rails.root.join("db", "data_export.json")

    unless File.exist?(export_path)
      puts "❌ No export file found at #{export_path}"
      exit 1
    end

    data = JSON.parse(File.read(export_path))

    # Import in correct order for foreign key dependencies
    import_order = [ "users", "lessons", "lesson_pages", "assessments", "questions", "assessment_attempts", "question_responses" ]

    # Disable foreign key checks during import
    ActiveRecord::Base.connection.execute("SET session_replication_role = 'replica';") if ActiveRecord::Base.connection.adapter_name == "PostgreSQL"

    import_order.each do |table_name|
      next unless data[table_name]

      model = table_name.classify.constantize
      records = data[table_name]

      # Skip if no records to import
      next if records.empty?

      puts "Importing #{records.count} #{table_name}..."

      records.each do |attrs|
        # Insert directly with preserved IDs
        columns = attrs.keys
        values = attrs.values.map { |v| ActiveRecord::Base.connection.quote(v) }

        sql = "INSERT INTO #{table_name} (#{columns.join(', ')}) VALUES (#{values.join(', ')})"
        ActiveRecord::Base.connection.execute(sql)
      end

      # Reset the primary key sequence for PostgreSQL
      if records.any? && ActiveRecord::Base.connection.adapter_name == "PostgreSQL"
        max_id = records.map { |r| r["id"] }.max
        ActiveRecord::Base.connection.execute(
          "SELECT setval('#{table_name}_id_seq', #{max_id})"
        )
      end

      puts "✓ Imported #{records.count} #{table_name}"
    end

    # Re-enable foreign key checks
    ActiveRecord::Base.connection.execute("SET session_replication_role = 'origin';") if ActiveRecord::Base.connection.adapter_name == "PostgreSQL"

    puts "\n✅ Data import complete!"
  end
end
