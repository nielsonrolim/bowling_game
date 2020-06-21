
# Bowling Game

This is a study project that simulates a bowling game reading a text file with the players throws and processes the scores of each player.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

All you need is Ruby 2.6 or later


### Installing

After clone the project, execute bin/setup

```
bin/setup
```

Then you are ready to go

## Running the tests

All the tests are in the spec folder

```
rspec
```

## Executing

To execute the game you need a file containing the players throws following this format:

* Each line represents a player and a chance with the subsequent number of pins knocked down.
* An 'F' indicates a foul on that chance and no pins knocked down (identical for scoring to a roll of 0).
* The rows are tab-separated.

Example files can be found at:

```
spec/fixtures/
```

To excute:
```
./bin/bowling_game.rb file.txt
```


## Authors

* **Nielson Rolim** - [PurpleBooth](https://github.com/nielsonrolim)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

