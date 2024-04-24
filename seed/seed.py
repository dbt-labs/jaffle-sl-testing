from argparse import ArgumentParser

from generator.impl import CustomersGenerator


def get_arg_parser() -> ArgumentParser:
    p = ArgumentParser()
    p.add_argument("--file", help="The output CSV file", required=True, action="store")
    p.add_argument(
        "--seed", help="The generation seed", required=True, action="store", type=int
    )
    return p


def main():
    parser = get_arg_parser()
    args = parser.parse_args()

    orders_gen = CustomersGenerator(seed=args.seed, row_count_range=(2000, 10000))
    orders_gen.generate(args.file)
    print("Done!")


if __name__ == "__main__":
    main()
