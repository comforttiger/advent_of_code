mod day1;
mod day2;
mod day3;
mod day4;
use dialoguer::{theme::ColorfulTheme, Select};

fn main() {
    let days = &["day 1", "day 2", "day 3", "day 4"];

    let selection_day = Select::with_theme(&ColorfulTheme::default())
        .with_prompt("")
        .default(3)
        .max_length(5)
        .items(&days[..])
        .interact()
        .unwrap();

    let parts = &["part 1", "part 2"];
    let part_selection = Select::with_theme(&ColorfulTheme::default())
        .with_prompt("")
        .default(1)
        .items(&parts[..])
        .interact()
        .unwrap();

    match selection_day {
        0 => day1::main(part_selection),
        1 => day2::main(part_selection),
        2 => day3::main(part_selection),
        3 => day4::main(part_selection),
        _ => panic!(),
    }
}
