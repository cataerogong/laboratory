import typer

app = typer.Typer()

@app.command()
def cmd1(arg: str):
    typer.echo(f'sub2.cmd1(arg={arg})')

@app.command()
def cmd2(arg: str):
    typer.echo(f'sub2.cmd2(arg={arg})')

if __name__ == "__main__":
    app()
