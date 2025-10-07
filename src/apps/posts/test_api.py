import pytest
from rest_framework.test import APIClient

from src.apps.posts.models import Post


@pytest.fixture
def api_client():
    """Fixture to provide an API client instance."""
    return APIClient()


@pytest.fixture
def sample_post():
    """Fixture to create a sample post in the database."""
    return Post.objects.create(
        username="testuser",
        title="Sample Title",
        content="Sample content for testing.",
    )


@pytest.mark.django_db
class TestPostAPI:
    """Test suite for the Post API endpoints."""

    def test_create_post_success(self, api_client):
        """
        Ensure we can create a new post object.
        """
        data = {
            "username": "bruna",
            "title": "My first post",
            "content": "Hello, CodeLeap!",
        }
        response = api_client.post("/careers/", data, format="json")

        assert response.status_code == 201
        assert Post.objects.count() == 1
        assert Post.objects.get().username == "bruna"

    def test_list_posts(self, api_client, sample_post):
        """
        Ensure we can retrieve a list of posts.
        """
        Post.objects.create(
            username="anotheruser",
            title="Another Title",
            content="More content.",
        )
        response = api_client.get("/careers/")

        assert response.status_code == 200
        assert len(response.data["results"]) == 2
        assert response.data["results"][0]["username"] == "anotheruser"

    def test_update_post_success(self, api_client, sample_post):
        """
        Ensure we can update an existing post.
        """
        data = {"title": "Updated Title", "content": "Updated content."}
        response = api_client.patch(f"/careers/{sample_post.id}/", data, format="json")

        assert response.status_code == 200
        sample_post.refresh_from_db()
        assert sample_post.title == "Updated Title"
        assert sample_post.username == "testuser"

    def test_delete_post_success(self, api_client, sample_post):
        """
        Ensure we can delete a post.
        """
        response = api_client.delete(f"/careers/{sample_post.id}/")
        assert response.status_code == 204
        assert Post.objects.count() == 0
