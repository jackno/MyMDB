from django.views.generic import (
    DetailView,
    ListView,
)

from core.models import Movie


class MovieList(ListView):
    model = Movie
    paginate_by = 10


class MovieDetail(DetailView):
    model = Movie

