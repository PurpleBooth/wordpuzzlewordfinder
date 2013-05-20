class DictionaryWord
  include MongoMapper::Document

  @@character_score_map = {
    "A" => 1,
    "B" => 4,
    "C" => 4,
    "D" => 2,
    "E" => 1,
    "F" => 4,
    "G" => 3,
    "H" => 3,
    "I" => 1,
    "J" => 10,
    "K" => 5,
    "L" => 2,
    "M" => 4,
    "N" => 2,
    "O" => 1,
    "P" => 4,
    "Q" => 10,
    "R" => 1,
    "S" => 1,
    "T" => 1,
    "U" => 2,
    "V" => 5,
    "W" => 4,
    "X" => 8,
    "Y" => 3,
    "Z" => 10
  }

  key :word, String
  key :score

  def to_s
    return word
  end

  def word=(new_word)
    @score = 0
    
    new_word.split("").each do |letter|
      @score += @@character_score_map[letter.upcase]
    end

    super(new_word)
  end

  def self.find_scrabble_words(letters, mask = false)
    letters = letters.gsub(/[^A-Za-z ]/, "").upcase if letters != false
    mask = mask.gsub(/[^\?\!\*A-Za-z ]/, "").upcase if mask != false
    query = {}

    if(mask != false && !mask.empty?) 
      force_needed_between = []
    
      mask.split(//).each_with_index do |letter, index|
        if(letter != "?" && letter != "*")
          force_needed_between.push index
        end
      
        if(letter != "?" && letter != "!" && letter != "*" && letters != false) 
          letters += letter
        end
      end
      
      while force_needed_between.size > 1 do
        neededfrom = force_needed_between.shift+1
        neededto = force_needed_between.pop-1
        
        if(neededfrom <= neededto) 
          (neededfrom..neededto).each do |index| 
            if(mask[index] == "?")
              mask[index] = "!"
            end
          end
        end
               
      end
      
      regex = "^"+mask.gsub("?", "[A-Z]?").gsub("*", "[A-Z]*").gsub("!", "[A-Z]")+"$"
      
      query["word"] = Regexp.new regex
    end
  
    if letters != false
      if mask == false
        regex = ""
        letters.length.times { regex += "[A-Z]?" }
        regex = "^"+regex+"$"
        query["word"] = Regexp.new regex
      end
      
      where = "
        function() {
           if(this.word.length > "+letters.upcase.to_json+".length) {
             return false;
           }
        
           var search_letters = "+letters.upcase.to_json+".split(\"\").sort();
           var stored_letters = this.word.split(\"\").sort();

           Array.prototype.contains = function(obj) {
               var i = this.length;
               while (i--) {
                   if (this[i] === obj) {
                       return i;
                   }
               }
               return false;
           }
           
           Array.prototype.remove = function(from, to) {
             var rest = this.slice((to || from) + 1 || this.length);
             this.length = from < 0 ? this.length + from : from;
             return this.push.apply(this, rest);
           };

           var blanks = (search_letters.join('').split(' ').length - 1);
           var search_i = 0;
           search_letters = search_letters.slice(blanks.length, search_letters.length)

	         for(var stored_i = 0; stored_i < stored_letters.length ; stored_i++) {
             var contains_letter = search_letters.contains(stored_letters[stored_i]);
             if(contains_letter === false) {
               if(blanks > 0) {
                 blanks--;
               }
               else {
                 return false;
               }
             }
             else {
               search_letters.remove(contains_letter)
             }
           }

           return true;
        }"
        
        query["$where"] = where
        
      end

    return where(query).order( "score desc, word").limit(1000)
  end
end
