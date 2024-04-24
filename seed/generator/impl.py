from functools import partial

from .generator import RowGenerator

CustomersGenerator = partial(
    RowGenerator, column_generators={"id": "uuid", "name": "name"}
)
