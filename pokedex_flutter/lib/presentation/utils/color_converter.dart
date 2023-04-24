import 'package:flutter/material.dart';

Color convertColor(String color){
  switch(color){
    case "normal":
      return Color(0xFFA8A77A);
    case "fire":
      return Color(0xFFEE8130);
    case "water":
      return Color(0xFF6390F0);
    case "electric":
      return Color(0xFFF7D02C);
    case "grass":
      return Color(0xFF7AC74C);
    case "ice":
      return Color(0xFF96D9D6);
    case "fighting":
      return Color(0xFFC22E28);
    case "poison":
      return Color(0xFFA33EA1);
    case "ground":
      return Color(0xFFE2BF65);
    case "flying":
      return Color(0xFFA98FF3);
    case "psychic":
      return Color(0xFFF95587);
    case "bug":
      return Color(0xFFA6B91A);
    case "rock":
      return Color(0xFFB6A136);
    case "ghost":
      return Color(0xFF735797);
    case "dragon":
      return Color(0xFF6F35FC);
    case "dark":
      return Color(0xFF705746);
    case "steel":
      return Color(0xFFB7B7CE);
    case "fairy":
      return Color(0xFFD685AD);
    default:
      return Colors.black;
  }
}