# Construct Insights from an NDS With the `[]`s

## Introduction

In this lab, we're going to generate our first insight: What is the total retail
value of the snacks in the vending machine. You're then going to complete a lab
where we calculate how much money the directors' movies made using the same
data from the previous lesson.

To accomplish this, we're going to continue following the strategy we described
a few lessons ago:

> 2. Use `[]` to verify your understanding from Step 1
>   * Print values to verify your understanding
>   * Leave code comments and documentation for yourself

What's so special about the `[]` method? By using `[]` to dig into `Array`s or
`Hash`es we can verify that we know how to "get" critical data out of the NDS.
Since we have a human-friendly picture of the NDS (thanks to Step 1), we can
make sure we get "get" the critical data back out by writing statements like
`vending_machine[0][1][0][:price]`. In that bit of code, the `[]` help us
"tunnel into" the NDS so that we have confidence when we go to extract
_insights_ from the NDS.

The good thing is that there's nothing new to learn here. We're just going to
apply what we know to a much larger data set, a complex NDS. In addition to the
`[]` method, we'll:

* use loops and variables to move through `Array`s and `Hash`es
* set and update variables to hold answers

Let's answer the question: "***What are all these snacks worth?***

## Building on NDS Exploring Code

In the previous lesson, we noted that code you write to explore an NDS is rarely
wasted.

```ruby
vm = [[[{:name=>"Vanilla Cookies", :price=>3}, {:name=>"Pistachio Cookies", :price=>3}, {:name=>"Chocolate Cookies", :price=>3}, {:name=>"Chocolate Chip Cookies", :price=>3}], [{:name=>"Tooth-Melters", :price=>12}, {:name=>"Tooth-Destroyers", :price=>12}, {:name=>"Enamel Eaters", :price=>12}, {:name=>"Dentist's Nightmare", :price=>20}], [{:name=>"Gummy Sour Apple", :price=>3}, {:name=>"Gummy Apple", :price=>5}, {:name=>"Gummy Moldy Apple", :price=>1}]], [[{:name=>"Grape Drink", :price=>1}, {:name=>"Orange Drink", :price=>1}, {:name=>"Pineapple Drink", :price=>1}], [{:name=>"Mints", :price=>13}, {:name=>"Curiously Toxic Mints", :price=>1000}, {:name=>"US Mints", :price=>99}]]]


row_index = 0
while row_index < vm.length do
  puts "Row #{row_index} has #{vm[row_index]} columns"

  column_index = 0
  while column_index < vm[row_index].length do
    coord = "#{row_index}, #{column_index}"
    inner_len = vm[row_index][column_index].length
    # Remember \t is a TAB character for indentation
    puts "\tCoordinate [#{coord}] points to an #{vm[row_index][column_index].class} of length #{inner_len}"

    inner_index = 0
    while inner_index < inner_len do
      puts "\t\t (#{coord}, #{inner_len}) is: #{vm[row_index][column_index][inner_index]}"
      inner_index += 1
    end

    column_index += 1
  end

  row_index += 1
end
```

Outputs:

```text
Row 0 has [[{:name=>"Vanilla Cookies", :price=>3}, {:name=>"Pistachio Cookies", :price=>3}, {:name=>"Chocolate Cookies", :price=>3}, {:name=>"Chocolate Chip Cookies", :price=>3}], [{:name=>"Tooth-Melters", :price=>12}, {:name=>"Tooth-Destroyers", :price=>12}, {:name=>"Enamel Eaters", :price=>12}, {:name=>"Dentist's Nightmare", :price=>20}], [{:name=>"Gummy Sour Apple", :price=>3}, {:name=>"Gummy Apple", :price=>5}, {:name=>"Gummy Moldy Apple", :price=>1}]] columns
	Coordinate [0, 0] points to an Array of length 4
		 (0, 0, 4) is: {:name=>"Vanilla Cookies", :price=>3}
		 (0, 0, 4) is: {:name=>"Pistachio Cookies", :price=>3}
		 (0, 0, 4) is: {:name=>"Chocolate Cookies", :price=>3}
		 (0, 0, 4) is: {:name=>"Chocolate Chip Cookies", :price=>3}
	Coordinate [0, 1] points to an Array of length 4
		 (0, 1, 4) is: {:name=>"Tooth-Melters", :price=>12}
		 (0, 1, 4) is: {:name=>"Tooth-Destroyers", :price=>12}
		 (0, 1, 4) is: {:name=>"Enamel Eaters", :price=>12}
		 (0, 1, 4) is: {:name=>"Dentist's Nightmare", :price=>20}
	Coordinate [0, 2] points to an Array of length 3
		 (0, 2, 3) is: {:name=>"Gummy Sour Apple", :price=>3}
		 (0, 2, 3) is: {:name=>"Gummy Apple", :price=>5}
		 (0, 2, 3) is: {:name=>"Gummy Moldy Apple", :price=>1}
Row 1 has [[{:name=>"Grape Drink", :price=>1}, {:name=>"Orange Drink", :price=>1}, {:name=>"Pineapple Drink", :price=>1}], [{:name=>"Mints", :price=>13}, {:name=>"Curiously Toxic Mints", :price=>1000}, {:name=>"US Mints", :price=>99}]] columns
	Coordinate [1, 0] points to an Array of length 3
		 (1, 0, 3) is: {:name=>"Grape Drink", :price=>1}
		 (1, 0, 3) is: {:name=>"Orange Drink", :price=>1}
		 (1, 0, 3) is: {:name=>"Pineapple Drink", :price=>1}
	Coordinate [1, 1] points to an Array of length 3
		 (1, 1, 3) is: {:name=>"Mints", :price=>13}
		 (1, 1, 3) is: {:name=>"Curiously Toxic Mints", :price=>1000}
		 (1, 1, 3) is: {:name=>"US Mints", :price=>99}
```

Based on this code and its output, we can slowly step toward a model of how to
get the prices we need to add together. As part of our strategy, we're still
printing out useful "debug" data to the screen. In that debug data we see a way
forward.  Instead of printing out:

`(1, 0, 3) is: {:name=>"Grape Drink", :price=>1}`

we can take the value pointed to by `:price` and add it to a grand total.
We'll build on the code we just demonstrated above, and add a few code comments
to help us remember what's happening inside our code.

```ruby
vm = [[[{:name=>"Vanilla Cookies", :price=>3}, {:name=>"Pistachio Cookies", :price=>3}, {:name=>"Chocolate Cookies", :price=>3}, {:name=>"Chocolate Chip Cookies", :price=>3}], [{:name=>"Tooth-Melters", :price=>12}, {:name=>"Tooth-Destroyers", :price=>12}, {:name=>"Enamel Eaters", :price=>12}, {:name=>"Dentist's Nightmare", :price=>20}], [{:name=>"Gummy Sour Apple", :price=>3}, {:name=>"Gummy Apple", :price=>5}, {:name=>"Gummy Moldy Apple", :price=>1}]], [[{:name=>"Grape Drink", :price=>1}, {:name=>"Orange Drink", :price=>1}, {:name=>"Pineapple Drink", :price=>1}], [{:name=>"Mints", :price=>13}, {:name=>"Curiously Toxic Mints", :price=>1000}, {:name=>"US Mints", :price=>99}]]]


grand_total = 0
row_index = 0
while row_index < vm.length do
  column_index = 0
  while column_index < vm[row_index].length do
    inner_len = vm[row_index][column_index].length
    inner_index = 0
    while inner_index < inner_len do
      # Explanation!
      # vm[row][column][spinner]
      # spinner is full of Hashes with keys :price and :name
      grand_total += vm[row_index][column_index][inner_index][:price]
      inner_index += 1
    end
    column_index += 1
  end
  row_index += 1
end

p grand_total #=> 1192
```

Look at that! It's an _insight_! All these snacks are worth `$1192.00`

## Lab

In this lab, you're going to work through the directors database and create a
`Hash` that records the director's name as a key, and the total grosses of all of their
movies as the value. For example:

```ruby
hash = {
  "1st Director's Name"=>1234567890,
  "2nd Director's Name"=>1234577890,
  "3rd Director's Name"=>1234709136,
  ...
}
```

## Conclusion

In this lesson, we used the "raw" or "basic" `Array` and `Hash` methods to
retrieve data out of an NDS. We even generated an insight: "total retail value
of all the snacks in the vending machine." Not bad!

But our code is notably lacking any methods. We've not done anything to make
our code _abstract_. The code we've written gets the job done, but all that
`[]` everywhere is hard for human eyes to read. Furthermore, without our
helpful comment that explains:

```ruby
# vm[row][column][spinner]
# spinner is full of Hashes with keys :price and :name
```

our code is very hard to read, understand, and maintain. To make this code
better _for other humans_, we'll turn to step three of our strategy.
