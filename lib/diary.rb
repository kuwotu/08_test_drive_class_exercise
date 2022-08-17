
class Diary
  def initialize
    @diary_list = []
  end
  def add(entry) # entry is an instance of DiaryEntry
    @diary_list << entry
  end
  def all
    @diary_list
  end
  def count_words
    # Returns the number of words in all diary entries
    # HINT: This method should make use of the `count_words` method on DiaryEntry.
    total_count = 0
    @diary_list.map {|entry| total_count += entry.count_words}
    return total_count
  end
  def reading_time(wpm) 
    fail "Reading speed must be above zero" unless wpm > 0
    return (count_words.to_f / wpm).ceil
    
  end
  def find_best_entry_for_reading_time(wpm, minutes)
    words_to_read = wpm * minutes
    entries_under_limit = @diary_list.filter {|entry| words_to_read >= entry.count_words}
    entries_under_limit.sort! { |a,b| b.count_words  <=> a.count_words }
    return entries_under_limit[0]
  end
end
