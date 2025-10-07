from rest_framework import mixins, viewsets
from rest_framework.permissions import AllowAny

from .models import Post
from .serializers import PostSerializer, PostUpdateSerializer


class PostViewSet(
    mixins.CreateModelMixin,
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    mixins.ListModelMixin,
    viewsets.GenericViewSet,
):
    """
    ViewSet to handle all CRUD operations for the Post model.
    """

    queryset = Post.objects.all()
    serializer_class = PostSerializer
    permission_classes = [AllowAny]

    def get_serializer_class(self):
        """
        Return the appropriate serializer class based on the request action.
        """
        if self.action in ["update", "partial_update"]:
            return PostUpdateSerializer
        return super().get_serializer_class()
