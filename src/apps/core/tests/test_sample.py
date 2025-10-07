import pytest


def test_addition():
    assert 1 + 1 == 2


@pytest.mark.django_db
def test_health_check_view(client):
    response = client.get("/api/v1/status/")
    assert response.status_code == 200
    assert response.json() == {"status": "ok", "service": "api"}
