pub fn main(part: usize) {
    let input = std::fs::read_to_string("inputs/3").unwrap();

    match part {
        0 => part1(input),
        1 => part2(input),
        _ => panic!(),
    }
}

pub fn part2(input: String) {
    let mut sum = 0;
    for (line_index, line) in input.lines().enumerate() {
        for (char_index, character) in line.chars().enumerate() {
            if !character.is_ascii_digit() && character == '*' {
                let gears = get_number(input.clone(), line_index, char_index);
                if gears.len() == 2 {
                    sum += gears[0] * gears[1]
                }
            }
        }
    }
    println!("{sum}");
}

pub fn part1(input: String) {
    let mut sum = 0;
    for (line_index, line) in input.lines().enumerate() {
        for (char_index, character) in line.chars().enumerate() {
            if !character.is_ascii_digit() && character != '.' {
                for number in get_number(input.clone(), line_index, char_index) {
                    sum += number;
                }
            }
        }
    }
    println!("{sum}");
}

fn get_number(input: String, line_index: usize, char_index: usize) -> Vec<u64> {
    let mut lines = Vec::new();
    let mut i = 0;
    if line_index != 0 {
        i = line_index - 1
    }
    for n in i..line_index + 2 {
        let line = input.lines().nth(n);
        if let Some(i) = line {
            lines.push(i);
        }
    }
    let mut numbers: Vec<u64> = Vec::new();

    for line in lines {
        let mut number_start: usize = 0;
        let mut number_end: usize = 0;
        let mut number = String::new();

        for (index, character) in line.chars().enumerate() {
            if character.is_ascii_digit() {
                if number.is_empty() {
                    number_start = index;
                    number_end = index;
                } else {
                    number_end = index;
                }
                number.push(character);
            } else if !character.is_ascii_digit()
                && !number.is_empty()
                && (number_start.abs_diff(char_index) <= 1 || number_end.abs_diff(char_index) <= 1)
            {
                numbers.push(number.parse().unwrap());
                number.clear()
            } else {
                number.clear()
            }
        }
        if !number.is_empty()
            && (number_start.abs_diff(char_index) <= 1 || number_end.abs_diff(char_index) <= 1)
        {
            numbers.push(number.parse().unwrap());
            number.clear();
        }
    }
    numbers
}
