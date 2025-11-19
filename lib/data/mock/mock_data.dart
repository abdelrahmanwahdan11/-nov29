import 'package:flutter/material.dart';
import 'package:nex_ride_ai_mobility/data/models/achievement.dart';
import 'package:nex_ride_ai_mobility/data/models/playlist_track.dart';
import 'package:nex_ride_ai_mobility/data/models/trip.dart';
import 'package:nex_ride_ai_mobility/data/models/user.dart';
import 'package:nex_ride_ai_mobility/data/models/vehicle.dart';

final demoUser = User(
  id: 'user-1',
  name: 'Layla Mendez',
  email: 'layla@nexride.ai',
  avatarUrl:
      'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?auto=format&fit=crop&w=240&q=80',
  ridesCount: 126,
  kilometers: 4230,
  hours: 319,
  favoriteVehiclesIds: const ['veh-1', 'veh-3'],
  preferredLanguageCode: 'en',
  preferredTheme: 'light',
  preferredPrimaryColorHex: '#2F6BFF',
);

final vehicles = <Vehicle>[
  const Vehicle(
    id: 'veh-1',
    brand: 'Lumine',
    model: 'Halo X',
    year: 2024,
    category: 'Electric',
    imageUrl:
        'https://images.unsplash.com/photo-1549924231-f129b911e442?auto=format&fit=crop&w=1200&q=80',
    seats: 4,
    power: '410 kW',
    rangeKm: 520,
    basePrice: 12.5,
    rating: 4.9,
    tags: ['Premium', 'EV'],
    descriptionShort: 'Silent electric cruiser with panoramic canopy.',
    descriptionLong:
        'Halo X keeps you comfortable with adaptive suspension and AI climate bubbles. Perfect for long commutes.',
  ),
  const Vehicle(
    id: 'veh-2',
    brand: 'Aero',
    model: 'Pulse GT',
    year: 2023,
    category: 'Sport',
    imageUrl:
        'https://images.unsplash.com/photo-1493238792000-8113da705763?auto=format&fit=crop&w=1200&q=80',
    seats: 2,
    power: '560 kW',
    rangeKm: 380,
    basePrice: 18.7,
    rating: 4.7,
    tags: ['Sport', 'Weekend'],
    descriptionShort: 'Low-slung icon tuned for playful city rides.',
    descriptionLong:
        'Pulse GT mixes supercar aesthetics with polite manners for downtown gliding. Includes adaptive soundscapes.',
  ),
  const Vehicle(
    id: 'veh-3',
    brand: 'Cobalt',
    model: 'Summit Max',
    year: 2022,
    category: 'SUV',
    imageUrl:
        'https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1200&q=80',
    seats: 6,
    power: '320 kW',
    rangeKm: 640,
    basePrice: 10.2,
    rating: 4.6,
    tags: ['Family', 'SUV'],
    descriptionShort: 'Commanding SUV that keeps teams synced on board.',
    descriptionLong:
        'Summit Max offers lounge seating, built-in AR dash and climate pods for every passenger. Ideal for business shuttles.',
  ),
];

final trips = <Trip>[
  Trip(
    id: 'trip-1',
    status: 'on_the_way',
    vehicleId: 'veh-1',
    pickupLocation: 'Downtown HQ',
    dropoffLocation: 'Airport T3',
    scheduledTime: DateTime.now().add(const Duration(hours: 2)),
    startTime: DateTime.now().subtract(const Duration(minutes: 10)),
    endTime: DateTime.now().add(const Duration(minutes: 30)),
    price: 42.70,
    distanceKm: 19.5,
    shareLink: 'https://nexride.ai/share/trip-1',
    mapImageUrl:
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',
  ),
  Trip(
    id: 'trip-2',
    status: 'completed',
    vehicleId: 'veh-3',
    pickupLocation: 'Little Havana',
    dropoffLocation: 'Brickell City',
    scheduledTime: DateTime.now().subtract(const Duration(days: 1)),
    startTime: DateTime.now().subtract(const Duration(days: 1, hours: -1)),
    endTime: DateTime.now().subtract(const Duration(days: 1, hours: -1, minutes: -30)),
    price: 28.00,
    distanceKm: 12.4,
    shareLink: 'https://nexride.ai/share/trip-2',
    mapImageUrl:
        'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?auto=format&fit=crop&w=1200&q=80',
  ),
  Trip(
    id: 'trip-3',
    status: 'completed',
    vehicleId: 'veh-2',
    pickupLocation: 'Design District',
    dropoffLocation: 'South Beach',
    scheduledTime: DateTime.now().subtract(const Duration(days: 3)),
    startTime: DateTime.now().subtract(const Duration(days: 3, hours: -2)),
    endTime: DateTime.now().subtract(const Duration(days: 3, hours: -1, minutes: -10)),
    price: 54.60,
    distanceKm: 32.0,
    shareLink: 'https://nexride.ai/share/trip-3',
    mapImageUrl:
        'https://images.unsplash.com/photo-1469478715127-7c631389bc21?auto=format&fit=crop&w=1200&q=80',
  ),
  Trip(
    id: 'trip-4',
    status: 'cancelled',
    vehicleId: 'veh-1',
    pickupLocation: 'Wynwood Hub',
    dropoffLocation: 'University Village',
    scheduledTime: DateTime.now().subtract(const Duration(days: 5)),
    startTime: DateTime.now().subtract(const Duration(days: 5)),
    endTime: DateTime.now().subtract(const Duration(days: 5)),
    price: 0,
    distanceKm: 0,
    shareLink: 'https://nexride.ai/share/trip-4',
    mapImageUrl:
        'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80',
  ),
  Trip(
    id: 'trip-5',
    status: 'completed',
    vehicleId: 'veh-3',
    pickupLocation: 'Coral Gables',
    dropoffLocation: 'Key Biscayne',
    scheduledTime: DateTime.now().subtract(const Duration(days: 7)),
    startTime: DateTime.now().subtract(const Duration(days: 7, hours: -3)),
    endTime: DateTime.now().subtract(const Duration(days: 7, hours: -2, minutes: -40)),
    price: 65.10,
    distanceKm: 41.2,
    shareLink: 'https://nexride.ai/share/trip-5',
    mapImageUrl:
        'https://images.unsplash.com/photo-1500534314215-6c8c8e9c90f4?auto=format&fit=crop&w=1200&q=80',
  ),
  Trip(
    id: 'trip-6',
    status: 'completed',
    vehicleId: 'veh-2',
    pickupLocation: 'Edgewater',
    dropoffLocation: 'SeaPort Village',
    scheduledTime: DateTime.now().subtract(const Duration(days: 10)),
    startTime: DateTime.now().subtract(const Duration(days: 10, hours: -1)),
    endTime: DateTime.now().subtract(const Duration(days: 10, hours: -1, minutes: -25)),
    price: 35.80,
    distanceKm: 21.6,
    shareLink: 'https://nexride.ai/share/trip-6',
    mapImageUrl:
        'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1200&q=80',
  ),
];

final playlist = <PlaylistTrack>[
  const PlaylistTrack(
    id: 'track-1',
    title: 'Skyline Run',
    artist: 'Nova Drive',
    durationSec: 212,
    coverImageUrl:
        'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=400&q=80',
  ),
  const PlaylistTrack(
    id: 'track-2',
    title: 'Neon Comfort',
    artist: 'City Pulse',
    durationSec: 198,
    coverImageUrl:
        'https://images.unsplash.com/photo-1470229538611-16ba8c7ffbd7?auto=format&fit=crop&w=400&q=80',
  ),
  const PlaylistTrack(
    id: 'track-3',
    title: 'Morning Charge',
    artist: 'Flux Duo',
    durationSec: 204,
    coverImageUrl:
        'https://images.unsplash.com/photo-1469478715127-7c631389bc21?auto=format&fit=crop&w=400&q=80',
  ),
];

final achievements = <Achievement>[
  Achievement(
    id: 'ach-1',
    title: 'City Explorer',
    description: 'Complete rides across five unique districts in one week.',
    progress: 0.7,
    badgeImageUrl:
        'https://images.unsplash.com/photo-1511396275275-4f55b04b0d5b?auto=format&fit=crop&w=300&q=80',
    accent: const Color(0xFF47E7FF),
  ),
  Achievement(
    id: 'ach-2',
    title: 'Eco Hero',
    description: 'Choose only electric vehicles for three consecutive trips.',
    progress: 0.45,
    badgeImageUrl:
        'https://images.unsplash.com/photo-1449960238630-7e720e630019?auto=format&fit=crop&w=300&q=80',
    accent: const Color(0xFF22C55E),
  ),
  Achievement(
    id: 'ach-3',
    title: 'Night Owl',
    description: 'Request late-night pickups more than four times this month.',
    progress: 0.9,
    badgeImageUrl:
        'https://images.unsplash.com/photo-1483721310020-03333e577078?auto=format&fit=crop&w=300&q=80',
    accent: const Color(0xFFFF6FD8),
  ),
];
