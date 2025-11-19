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
