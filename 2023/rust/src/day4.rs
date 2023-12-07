pub fn main(part: usize) {
    let input = std::fs::read_to_string("inputs/4").unwrap();

    match part {
        0 => part1(input),
        1 => part2(input),
        _ => panic!(),
    }
}

pub fn part2(input: String) {
    let mut cards_amt: Vec<usize> = vec![1; input.lines().count()];
    let mut sum = input.lines().count();
    for (index, line) in input.lines().enumerate() {
        let repeat = cards_amt[index];
        let (winning_numbers, card) = line.split_once(':').unwrap().1.split_once('|').unwrap();
        let winning_numbers: Vec<&str> = winning_numbers.split_whitespace().collect();
        let winners = card
            .split_whitespace()
            .filter(|x| winning_numbers.contains(x))
            .count();
        cards_amt
            .iter_mut()
            .take(index + winners + 1)
            .skip(index)
            .for_each(|x| *x += repeat);
        sum += winners * repeat;
    }
    println!("{sum}");
}

pub fn part1(input: String) {
    let mut sum = 0;
    for line in input.lines() {
        let (winning_numbers, card) = line.split_once(':').unwrap().1.split_once('|').unwrap();
        let winning_numbers: Vec<&str> = winning_numbers.split_whitespace().collect();
        let winners = card
            .split_whitespace()
            .filter(|x| winning_numbers.contains(x))
            .count();
        if winners > 0 {
            sum += 2_u32.pow((winners - 1) as u32);
        }
    }
    println!("{sum}");
}
