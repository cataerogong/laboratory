import typer

app = typer.Typer()

@app.command()
def main(arg: str):
    typer.echo(f'sub(arg={arg})')

if __name__ == "__main__":
    app()
