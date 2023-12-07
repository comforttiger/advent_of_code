pub fn main(part: usize) {
    let input = std::fs::read_to_string("inputs/1").unwrap();

    match part {
        0 => task1(input),
        1 => task2(input),
        _ => panic!(),
    }
}

pub fn task2(mut input: String) {
    input = input
        .replace("one", "o1e")
        .replace("two", "t2o")
        .replace("three", "t3e")
        .replace("four", "f4r")
        .replace("five", "f5e")
        .replace("six", "s6x")
        .replace("seven", "s7n")
        .replace("eight", "e8t")
        .replace("nine", "n9e");

    task1(input);
}

pub fn task1(input: String) {
    let mut sum = 0;

    for line in input.lines() {
        sum +=
            char::to_digit(line.chars().find(|&x| x.is_ascii_digit()).unwrap(), 10).unwrap() * 10;
        sum += char::to_digit(line.chars().rfind(|&x| x.is_ascii_digit()).unwrap(), 10).unwrap();
    }
    println!("{}", sum);
}
