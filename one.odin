package main

import "core:os"
import "core:strings"
import "core:fmt"

is_digit :: proc(c: u8) -> bool{
    if c > 47 && c < 58{
        return true
    }
    return false
}

to_int :: proc(data: string) -> int{
    count := 0
    for char in data{
        char := u8(char)
        if is_digit(char){
            num: int = int(char - 48) //to change from ascii to numbers
            count = (count * 10) + num
        }
    }
    return count
}
main :: proc(){
	data, ok := os.read_entire_file("input_1.txt")
    	if !ok {
        fmt.println("Couldn't read a file") 
		return
	}
	defer delete(data, context.allocator)

    most_calories := 0
    second_most := 0
    third_most := 0
    temp_most := 0

	it := string(data)
	for line in strings.split_lines_iterator(&it) {
        if len(line) != 0{
            temp_most += to_int(line)
        }
        else{
            if temp_most > most_calories{
                third_most = second_most
                second_most = most_calories
                most_calories = temp_most
            }
            else if temp_most > second_most{
                third_most = second_most
                second_most = temp_most
            }
            else if temp_most > third_most{
                third_most = temp_most
            }
            temp_most = 0
        }
	}
    if temp_most > most_calories{
        third_most = second_most
        second_most = most_calories
        most_calories = temp_most
    }
    else if temp_most > second_most{
        third_most = second_most
        second_most = temp_most
    }
    else if temp_most > third_most{
        third_most = temp_most
        }
            
    fmt.println(most_calories + third_most + second_most)
}