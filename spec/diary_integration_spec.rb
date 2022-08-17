# 1 add
# blueBook = Diary.new
# monday_17th_22 = DiaryEntry.new("Football training", "sports " * 100)
# monday_19th_22 = DiaryEntry.new("Library", "studying " * 100)
# blueBook.add(monday_17th_22) 
# blueBook.add(monday_19th_22)
# blueBook.all => [monday_17th_22, monday_17th_22]

# 2

require "diary_entry"
require "diary"

RSpec.describe "Diary Entry Integration" do
    describe "#add" do
        it "adds an instance of the diary entry to the diary list" do
            blue_book = Diary.new
            monday_17th_22 = DiaryEntry.new("Football training", "sports " * 100)
            blue_book.add(monday_17th_22) 
            result = blue_book.all
            expect(result).to eq [monday_17th_22]
        end
    end

    describe "#count_words" do
        it "returns the total number of words from the diary entries in the diary list" do
            blue_book = Diary.new
            monday_17th_22 = DiaryEntry.new("Football training", "sports " * 100)
            friday_22nd_22 = DiaryEntry.new("Library", "studying " * 190)
            blue_book.add(monday_17th_22) 
            blue_book.add(friday_22nd_22) 
            result = blue_book.count_words
            expect(result).to eq 290
        end
    end

    describe "#reading_time" do
        it "returns the total amount of time it would take to read all diary entries" do
            blue_book = Diary.new
            monday_17th_22 = DiaryEntry.new("Football training", "sports " * 300)
            friday_22nd_22 = DiaryEntry.new("Library", "studying " * 400)
            blue_book.add(monday_17th_22) 
            blue_book.add(friday_22nd_22) 
            result = blue_book.reading_time(100)
            expect(result).to eq 7
        end

        it "fails" do
            blue_book = Diary.new
            monday_17th_22 = DiaryEntry.new("Football training", "sports " * 300)
            blue_book.add(monday_17th_22) 
            expect {blue_book.reading_time(0)}.to raise_error "Reading speed must be above zero" 
        end
    end

    describe "#find_best_entry_for_reading_time" do
        it "returns the entry closest to the reading time the user has available" do
            blue_book = Diary.new
            monday_17th_22 = DiaryEntry.new("Football training", "sports " * 100)
            wednesday_19th_22 = DiaryEntry.new("Ice Skating", "fun " * 140)
            friday_22nd_22 = DiaryEntry.new("Library", "studying " * 190)
            blue_book.add(monday_17th_22) 
            blue_book.add(wednesday_19th_22) 
            blue_book.add(friday_22nd_22) 
            result = blue_book.find_best_entry_for_reading_time(50, 3)
            expect(result).to eq wednesday_19th_22
        end
    end

end
