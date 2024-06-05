class TrackChanges
  def initialize(model_class, ids, start_date, end_date)
    @model_class = model_class
    @ids = ids
    @start_date = start_date
    @end_date = end_date
  end

  def call
    @ids.each_with_object({}) do |id, result|
      model_instance = @model_class.find(id)

      unless model_instance.paper_trail.enabled?
        raise "#{model_instance.class} does not have PaperTrail enabled"
      end

      result[id] = track_changes(model_instance)
      output_changes(result)
    end
  end

  private

  def track_changes(model_instance)
    versions = model_instance.versions.where(created_at: @start_date..@end_date)
    timeline = {}

    versions.each do |version|
      changes = version.object_changes ? YAML.load(version.object_changes) : {}
      next if changes.empty?

      timestamp = version.created_at.strftime("%Y-%m-%d %H:%M:%S")
      timeline[timestamp] = {}

      changes.each do |attribute, (old_value, new_value)|
        timeline[timestamp][attribute] = { from: old_value, to: new_value }
      end
    end

    timeline
  end

  def output_changes(result)
    result.each do |id, timeline|
      puts "Changes for #{@model_class.name} #{id}:"
      timeline.each do |timestamp, changes|
        puts "\e[1mChanges on #{timestamp}:\e[0m" # \e[1m starts bold text, \e[0m ends it
        changes.each do |attribute, change|
          from_value = change[:from].nil? || change[:from].to_s.empty? ? "\e[31mnil\e[0m" : change[:from]
          to_value = change[:to].nil? || change[:to].to_s.empty? ? "\e[31mnil\e[0m" : change[:to]
          puts "    #{attribute}: #{from_value} -> #{to_value}"
        end
      end
      puts
    end
  end
end