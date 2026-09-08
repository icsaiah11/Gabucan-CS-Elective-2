import 'package:flutter/material.dart';

import '../models/paddle.dart';

const List<Paddle> paddles = <Paddle>[
  Paddle(
      id: 'selkirk-luxx',
      brand: 'Selkirk',
      name: 'LUXX Control Air',
      price: 14250,
      badge: 'CONTROL',
      background: Color(0xFFE8E4FF),
      description:
          'A plush, precise paddle built for confident resets and controlled placement.',
      imagePath: 'assets/images/selkirk_luxx.png'),
  Paddle(
      id: 'joola-hyperion',
      brand: 'JOOLA',
      name: 'Hyperion C2',
      price: 12500,
      badge: 'POWER',
      background: Color(0xFFFFE4D6),
      description:
          'An aggressive all-court paddle with a responsive feel and reliable power.',
      imagePath: 'assets/images/joola_hyperion.png'),
  Paddle(
      id: 'crbn-1x',
      brand: 'CRBN',
      name: 'Power Series 1X',
      price: 13000,
      badge: 'ALL COURT',
      background: Color(0xFFD9F1E3),
      description:
          'Carbon-fiber performance that balances spin, pop, and everyday control.',
      imagePath: 'assets/images/crbn_1x.png'),
  Paddle(
      id: 'paddletek-bantam',
      brand: 'Paddletek',
      name: 'Bantam TKO-C',
      price: 14250,
      badge: 'ATTACK',
      background: Color(0xFFDDF0FA),
      description:
          'Designed for fast hands and a direct, attacking style of play.',
      imagePath: 'assets/images/paddletek_bantam.png'),
  Paddle(
      id: 'engage-pursuit',
      brand: 'Engage',
      name: 'Pursuit Pro EX',
      price: 14700,
      badge: 'SPIN',
      background: Color(0xFFFFEDBC),
      description:
          'A spin-focused option for players who want shape and precision on every shot.',
      imagePath: 'assets/images/engage_pursuit.png'),
  Paddle(
      id: 'six-zero',
      brand: 'Six Zero',
      name: 'Double Black',
      price: 10200,
      badge: 'HYBRID',
      background: Color(0xFFF0E2E9),
      description:
          'A versatile hybrid paddle with a comfortable, balanced response.',
      imagePath: 'assets/images/six_zero.png'),
];
