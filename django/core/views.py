from django.views.generic import (
    DetailView,
    ListView,
)

from core.models import Movie


class MovieList(ListView):
    model = Movie


class MovieDetail(DetailView):
    model = Movie

