from faker import Faker
from typing import Iterable

from .providers import ALL_PROVIDERS

ColumnGeneratorMap = dict[str, str]


class RowGenerator:
    """Base class for fake data generator generator."""

    def __init__(
        self,
        seed: int,
        row_count_range: tuple[int, int],
        column_generators: ColumnGeneratorMap,
    ) -> None:
        """Initialize the generator.

        Args:
            seed: the seed that will be used to generate fake data.
            row_count_range: the (min, max) range (inclusive) used to determine
                a count of rows to generate.
            column_generators: a mapping of column names to Faker providers.
        """
        self._faker = Faker()
        self.seed = seed

        for provider in ALL_PROVIDERS:
            self._faker.add_provider(provider)

        self._row_count_range = row_count_range
        self._column_generators = column_generators

    def _generate_row(self) -> Iterable[str]:
        """Generate a single row."""
        return (getattr(self._faker, gen)() for gen in self._column_generators.values())

    def generate(self, csv_path: str) -> None:
        """Generate the fake data and overwrite it to the file at `csv_path`.

        Note that calling this will reseed the global `Faker` since they dropped
        support for per-instance seeding.
        """
        Faker.seed(self.seed)
        num_rows = self._faker.random.randint(
            self._row_count_range[0], self._row_count_range[1]
        )
        with open(csv_path, "w") as file:
            file_header = ",".join(self._column_generators.keys())
            file.write(file_header + "\n")
            for _ in range(num_rows):
                row = self._generate_row()
                row_str = ",".join(str(x) for x in row)
                file.write(row_str + "\n")
