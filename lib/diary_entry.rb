class DiaryEntry
    def initialize(title, contents) # title, contents are strings
      @title = title
      @contents = contents
      @furthest_read_marker = 0
    end
    def title
      return @title
    end
    def contents
      return @contents
    end
    def count_words
        return words.length
      # Returns the number of words in the contents as an integer
    end
    def reading_time(wpm) 
        fail "Reading speed must be above zero" unless wpm > 0
       return (count_words.to_f / wpm).ceil
      
    end
        def reading_chunk(wpm, minutes)
            fail "Reading speed must be above zero" unless wpm > 0 # can use wpm.positive? instead
            words_that_can_be_read = wpm * minutes
            start_from = @furthest_read_marker
            end_at = @furthest_read_marker + words_that_can_be_read
            word_list = words[start_from, end_at]
            if end_at >= count_words
                @furthest_read_marker = 0
            else
                @furthest_read_marker = end_at
            end
            return word_list.join(" ")
    end

    private

    def words   
        return @contents.split(" ")
    end

  end