# puzzleish.rb pat@billspat.com
# dwtfyw license
#
# very simplistic cipher/decipher : converts string into numeric code based on alphabetic indexing 
# uses a starter or base number, a multiplier number, and a list of letters used for indexing that includes 
# all of the letters in the secret
# example
# s = 8; m = 38; letters = "ehlo"
# secret_code =  Puzzelish.new(s,m,letters).encode("hello")
# secret = Puzzleish.new(s,m,letters).decode(secret_code)

# there must be a better way to do this (make a GEM, probably)
raise "Ruby 1.9.1 required" if RUBY_VERSION.split('.')[0,3].join.to_i < 191


class Puzzelish
    
    attr_writer :code, :secret
    
    def initialize(starter,multiplier,letterlist)

        @starter = starter     # starter = base number
        @multiplier = multiplier  # number to multipl 
        @letterlist = letterlist  # cypher alphabet, indexing secret letters
        @code = nil
        @secret = nil        
    end
    
    public 
    
    def valid?(code)
        # valid if at least one multiplier (e.g. one letter)
        ( code >= @starter * @multiplier )
        # ToDo: test code.numeric?        
    end
    
    def encode(secret)
        # convert secret string 
        @code = @starter
        secret.chars.each {|c| @code = @code * @multiplier + @letterlist.index(c) }
        @code
    end
        
    def decode(code)
        return if not valid?(code)
        @secret = ""
        @code = code
        while @code >=  @starter * @multiplier
            letter_index = @code % @multiplier
            @code = (@code - letter_index ) / @multiplier
            @secret.insert(0, @letterlist[letter_index])
        end
        @secret        
    end  

end
