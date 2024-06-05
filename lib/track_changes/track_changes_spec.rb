# track_changes_spec.rb
require 'rspec'
require 'date'
require 'YAML'
require_relative 'track_changes'

RSpec.describe TrackChanges do
  let(:model_class) { double('ModelClass', name: 'ModelClass') }
  let(:ids) { [1, 2, 3] }
  let(:start_date) { Date.new(2024, 1, 1) }
  let(:end_date) { Date.new(2024, 12, 31) }
  let(:track_changes) { TrackChanges.new(model_class, ids, start_date, end_date) }

  describe '#call' do
    let(:model_instance) { double('ModelInstance', paper_trail: double(enabled?: true)) }
    let(:versions) { [double('Version', created_at: start_date, object_changes: "---\nname:\n- Alice\n- Bob\n")] }

    before do
      allow(model_class).to receive(:find).and_return(model_instance)
      allow(model_instance).to receive_message_chain(:versions, :where).and_return(versions)
    end

    it 'tracks changes for each id' do
      expect(track_changes.call).to eq({
                                         1 => { "2024-01-01 00:00:00" => { "name" => { from: "Alice", to: "Bob" } } },
                                         2 => { "2024-01-01 00:00:00" => { "name" => { from: "Alice", to: "Bob" } } },
                                         3 => { "2024-01-01 00:00:00" => { "name" => { from: "Alice", to: "Bob" } } }
                                       })
    end
  end
end