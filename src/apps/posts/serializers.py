from rest_framework import serializers

from .models import Post


class PostSerializer(serializers.ModelSerializer):
    """
    Serializer for reading and creating posts.
    """

    class Meta:
        model = Post
        fields = [
            "id",
            "username",
            "created_datetime",
            "title",
            "content",
        ]
        read_only_fields = ["id", "created_datetime"]


class PostUpdateSerializer(serializers.ModelSerializer):
    """
    Serializer specifically for updating posts.
    Ensures that username and creation time cannot be altered.
    """

    class Meta:
        model = Post
        fields = ["title", "content"]
