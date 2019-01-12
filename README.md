# Tictac

This is my experimentation, trying to learn Elixir while following [Alchemist Camp](https://alchemist.camp/episodes/tictac-game-board).

_**Note:** I know that a lot of things can be improved in this game. For example, ability to run by command `mix run` would have been good (and honestly, that's an easy one). However, the point of this experiment was not to create a production grade game but experiment with powerful pattern matching in Elixir to implement a simple state machine._

---

## How to start

To play this game, we need to have **Elixir** and **Erlang** installed. Follow [this](https://elixir-lang.org/install.html) for setup instructions.

After the setup, let's run the following in our shell:

```sh
git clone git@github.com:exanup/tictac.git
cd tictac
iex -S mix
```

We then see the **Erlang/OTP REPL**.

The game starts by invoking a function called `play/0` inside the module called `Tictac.CLI`. Hence, to start the game, we could just:

```elixir
Tictac.CLI.play
```

But, to make it easier for quicker starts, let's import the module like so:

```elixir
import Tictac.CLI
```

Then, every time we want to start a new game, we just call the function called `play/0` like so:

```elixir
play
```

If we were to change any code in the editor, and wanted to see the changes reflected, we would have entered the following in the REPL one after another:
```elixir
recomplile
play
```

Have fun! 😁
