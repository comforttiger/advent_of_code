pub fn main(part: usize) {
    let input = std::fs::read_to_string("inputs/2").unwrap();

    match part {
        0 => part1(input),
        1 => part2(input),
        _ => panic!(),
    }
}

pub fn part2(input: String) {
    let mut sum = 0;

    for line in input.lines() {
        let (mut biggest_red, mut biggest_green, mut biggest_blue) = (0, 0, 0);
        for round in line.split(':').nth(1).unwrap().split(';') {
            for cube in round.split(',') {
                let number: usize = cube.split_whitespace().next().unwrap().parse().unwrap();
                let color = cube.split_whitespace().nth(1).unwrap();
                match color {
                    "red" => biggest_red = biggest_red.max(number),
                    "green" => biggest_green = biggest_green.max(number),
                    "blue" => biggest_blue = biggest_blue.max(number),
                    _ => panic!(),
                }
            }
        }
        sum += biggest_red * biggest_blue * biggest_green;
    }
    println!("{sum}");
}

pub fn part1(input: String) {
    let mut sum = 0;
    for (index, line) in input.lines().enumerate() {
        let mut is_impossible: bool = false;

        for round in line.split(':').nth(1).unwrap().split(';') {
            for cube in round.split(',') {
                let number: usize = cube.split_whitespace().next().unwrap().parse().unwrap();
                let color = cube.split_whitespace().nth(1).unwrap();
                is_impossible = is_impossible
                    || match color {
                        "red" => number > 12,
                        "green" => number > 13,
                        "blue" => number > 14,
                        _ => panic!(),
                    };
            }
        }
        if !is_impossible {
            sum += index + 1;
        }
    }
    println!("{sum}");
}
