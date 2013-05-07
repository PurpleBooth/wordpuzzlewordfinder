namespace :wordlist do
  desc "Load and alter wordlists into the database"
  task :load, [:filename] => :environment do |t, args|
    puts "Purging the DB"
    DictionaryWord.delete_all
    
    puts "Refreshing from file"
    File.open(args.filename).each do |line|

      word = DictionaryWord.new
      word.word = line.upcase.strip
      word.save
    end
  end
end
