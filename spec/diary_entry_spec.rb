# 1 - title method

# monday_17th_22 = DiaryEntry.new("Football training", "sports " * 100)
# monday_17th_22.title => "Football training"

# 2 - contents method

# monday_17th_22 = DiaryEntry.new("Football training", "sports " * 100)
# monday_17th_22.contents => "sports " * 100

# 3 - count_words method

# monday_17th_22 = DiaryEntry.new("Football training", "sports " * 100)
# monday_17th_22.count_words => 100

# 3 - count_words method

# monday_17th_22 = DiaryEntry.new("Football training", "sports " * 100)
# monday_17th_22.count_words => 100

# 3 - reading_time method

# monday_17th_22 = DiaryEntry.new("Football training", "sports " * 600)
# monday_17th_22.reading_time(100) => 6

require 'diary_entry'
RSpec.describe DiaryEntry do
    it "constructs" do
        diary_entry = DiaryEntry.new("Jounal Entry", "This is the first entry in my journal")
        expect(diary_entry.title).to eq "Jounal Entry"
        expect(diary_entry.contents).to eq "This is the first entry in my journal"
    end
    describe "#count_words" do
        it "returns number of words in the contents" do
            diary_entry = DiaryEntry.new("Jounal Entry", "This is the first entry in my journal")
            expect(diary_entry.count_words).to eq 8
        end
        it "returns zero when contents is empty" do
            diary_entry = DiaryEntry.new("Jounal Entry", "")
            expect(diary_entry.count_words).to eq 0
        end
    end
    describe "#reading_time" do
        context "given a realistic reading rate in words per minute (wpm), such as 200" do
            it "returns the ceiling of the number of minutes it takes to read the contents" do
                diary_entry = DiaryEntry.new("Jounal Entry", "one " * 550)
                expect(diary_entry.reading_time(200)).to eq 3
            end
        end
        context "given a wpm of 0" do
            it "fails" do
                diary_entry = DiaryEntry.new("Jounal Entry", "one two three")
                expect { diary_entry.reading_time(0) }.to raise_error "Reading speed must be above zero"
            end
        end
    end
    describe "#reading_chunk" do
        context "given contents readable within the available minutes" do
            it "returns the full contents" do
                diary_entry = DiaryEntry.new("Jounal Entry", "one two three")
                chunk = diary_entry.reading_chunk(200, 1)
                expect(chunk).to eq "one two three"
            end
        end
        context "given a wpm of 0" do
            it "fails" do
                diary_entry = DiaryEntry.new("Jounal Entry", "one two three")
                expect { diary_entry.reading_chunk(0, 5) }.to raise_error "Reading speed must be above zero"
            end
        end
        context "given contents unreadable within the available time" do
            it "returns a readable chunk" do
                diary_entry = DiaryEntry.new("Jounal Entry", "one two three")
                chunk = diary_entry.reading_chunk(2, 1)
                expect(chunk).to eq "one two"
            end
            it "returns the next chunk next time reading_chunk method is called" do
                diary_entry = DiaryEntry.new("Jounal Entry", "one two three")
                diary_entry.reading_chunk(2, 1)
                chunk = diary_entry.reading_chunk(2, 1)
                expect(chunk).to eq "three"
            end
            it "restarts after reading the whole contents" do
                diary_entry = DiaryEntry.new("Jounal Entry", "one two three")
                diary_entry.reading_chunk(2, 1)
                diary_entry.reading_chunk(2, 1)
                chunk = diary_entry.reading_chunk(2, 1)
                expect(chunk).to eq "one two"
            end
            # What if we finish exactly on the end?
            it "restarts if it finishes exactly on the end" do
                diary_entry = DiaryEntry.new("Jounal Entry", "one two three")
                diary_entry.reading_chunk(2, 1)
                diary_entry.reading_chunk(1, 1)
                chunk = diary_entry.reading_chunk(2, 1)
                expect(chunk).to eq "one two"
            end            
        end
    end
end