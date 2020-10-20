

module Enumerable
    def my_each
        self.length.times do |k|
            yield self[k]
        end
        self
    end
 
    def my_each_with_index
        self.length.times do |j|
            yield j
        end
        self
    end

    def my_select
        selected_elements = []
        self.my_each do |k|
            selected_elements.push(k) if (yield k)
        end
        selected_elements
    end
    
    def my_all?
        self.my_each do |ele|              
            #returns false if an element that doesn't satsify the condition is found     
            return false unless yield ele
        end
        true         
    end

    def my_any?
        self.my_each do |ele|
            return true if yield ele
        end
        false
    end

    def my_none?
        self.my_each do |ele|
            return false if yield ele
        end
        true
    end

    def my_count
        count=0
        self.my_each do |ele|
            count+=1 if yield ele
        end
        count
    end


    
end