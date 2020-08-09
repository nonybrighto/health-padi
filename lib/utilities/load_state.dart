abstract class LoadState{}

class Loading extends LoadState{
  
  final bool more;
  Loading({this.more});
}

class Loaded extends LoadState{

     final bool hasReachedMax;
     Loaded({this.hasReachedMax});
} 

class LoadedEmpty extends LoadState{

    final String message;
    LoadedEmpty(this.message);
}

class LoadError extends LoadState {

   final String message;
   final bool more;

   LoadError({this.message, this.more});
}

