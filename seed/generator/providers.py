from uuid import UUID
from faker.providers import BaseProvider


class UUIDProvider(BaseProvider):
    """Provide a reproducible UUID."""

    def uuid(self) -> UUID:
        """Generate a fake UUID."""
        return UUID(int=self.generator.random.getrandbits(128), version=4)


ALL_PROVIDERS = [
    UUIDProvider,
]
