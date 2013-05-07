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

  def self.find_scrabble_words(letters)
    where = "
      function() {
         var search_letters = "+letters.upcase.to_json+".split(\"\").sort();
         var stored_letters = this.word.split(\"\").sort();

         if(stored_letters.length > search_letters.length) {
           return false;
         }

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

         var blanks = 0;
         var search_i = 0;

         for (var search_i=0; search_i < search_letters.length; search_i++) {
           if(search_letters[search_i] != ' ') {
             break;
           }
           
           blanks++;
         }

         for(var i = blanks ; i > 0 ; i--) {
           search_letters.unshift();
         }

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

    return where({"$where" => where}).order( "score desc, word")
  end
end
