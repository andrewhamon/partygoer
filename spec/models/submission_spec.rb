require "rails_helper"

RSpec.describe Submission, type: :model do
  describe ".queue_order" do
    it "orders by score" do
      queued1 = create(:submission, score: 2)
      queued3 = create(:submission, score: -1)
      queued2 = create(:submission, score: 1)

      expect(Submission.queue_order).to eq [queued1, queued2, queued3]
    end

    it "breaks ties by favoring the older submission" do
      reference_time = Time.zone.now

      queued1 = create(:submission, score: 2, created_at: reference_time)
      queued2 = create(:submission, score: 2, created_at: reference_time + 1.minute)
      queued3 = create(:submission, score: 1, created_at: reference_time + 1.minute)

      expect(Submission.queue_order).to eq [queued1, queued2, queued3]
    end

    it "always favors playing tracks" do
      queued1 = create(:submission, score: 50)
      playing = create(:submission, :playing, score: 1)
      queued2 = create(:submission, score: 49)

      expect(Submission.queue_order).to eq [playing, queued1, queued2]
    end
  end

  describe "order_by_playing" do
    it "puts playing tracks first" do
      queued1 = create(:submission)
      playing = create(:submission, :playing)
      queued2 = create(:submission)

      expect(Submission.order_by_playing.first).to eq playing
      expect(Submission.order_by_playing).to match_array [playing, queued1, queued2]
    end
  end
end
