import 'package:flutter/material.dart';

abstract class IMoviesRepository{
  void getMovieList(int pageNum);
  void getDetailMovieList(int id);
  void getYoutubeLink(int id);
}


