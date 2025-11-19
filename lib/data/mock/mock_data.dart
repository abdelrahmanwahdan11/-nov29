import 'package:flutter/material.dart';
import 'package:nex_ride_ai_mobility/data/models/achievement.dart';
import 'package:nex_ride_ai_mobility/data/models/cabin_mood.dart';
import 'package:nex_ride_ai_mobility/data/models/city_pulse_story.dart';
import 'package:nex_ride_ai_mobility/data/models/community_challenge.dart';
import 'package:nex_ride_ai_mobility/data/models/eco_reward.dart';
import 'package:nex_ride_ai_mobility/data/models/journey_moment.dart';
import 'package:nex_ride_ai_mobility/data/models/fleet_update.dart';
import 'package:nex_ride_ai_mobility/data/models/playlist_track.dart';
import 'package:nex_ride_ai_mobility/data/models/pulse_forecast.dart';
import 'package:nex_ride_ai_mobility/data/models/ride_journal_entry.dart';
import 'package:nex_ride_ai_mobility/data/models/route_insight.dart';
import 'package:nex_ride_ai_mobility/data/models/trip.dart';
import 'package:nex_ride_ai_mobility/data/models/user.dart';
import 'package:nex_ride_ai_mobility/data/models/vehicle.dart';
import 'package:nex_ride_ai_mobility/data/models/wellness_metric.dart';

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

final cityPulseStories = <CityPulseStory>[
  CityPulseStory(
    id: 'pulse-1',
    title: 'Hyperloop trial paused at Midtown portal',
    description:
        'Maintenance crews are recalibrating the magnetic runways. Alternate EV caravans will handle premium transfers.',
    tag: 'Mobility lab',
    imageUrl:
        'https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1200&q=80',
    publishedAt: DateTime.now().subtract(const Duration(hours: 3)),
    highlight: 'Expect 4 min detours for airport rides',
  ),
  CityPulseStory(
    id: 'pulse-2',
    title: 'SeaGlass avenue converted to bike-first boulevard',
    description:
        'City sensors detected a 42% drop in air particles since the pilot. NexRide EVs glide at limited speed to blend in.',
    tag: 'City climate',
    imageUrl:
        'https://images.unsplash.com/photo-1469478715127-7c631389bc21?auto=format&fit=crop&w=1200&q=80',
    publishedAt: DateTime.now().subtract(const Duration(hours: 9)),
    highlight: 'Earn double eco points along the corridor',
  ),
  CityPulseStory(
    id: 'pulse-3',
    title: 'NexRide holo-stations test adaptive lighting',
    description:
        'New platform domes shift hues based on rider mood boards. Beta testers can opt-in via Labs > Sense Grid.',
    tag: 'Labs',
    imageUrl:
        'https://images.unsplash.com/photo-1500534314215-6c8c8e9c90f4?auto=format&fit=crop&w=1200&q=80',
    publishedAt: DateTime.now().subtract(const Duration(hours: 20)),
  ),
];

final wellnessMetrics = <WellnessMetric>[
  const WellnessMetric(
    id: 'well-1',
    label: 'Calm minutes',
    value: 126,
    unit: 'min',
    trend: 12,
    description: 'Guided breathing & adaptive cabin light kept you relaxed.',
  ),
  const WellnessMetric(
    id: 'well-2',
    label: 'Focus streak',
    value: 4,
    unit: 'days',
    trend: 8,
    description: 'Quiet cabin preset engaged for four consecutive work rides.',
  ),
  const WellnessMetric(
    id: 'well-3',
    label: 'Hydration nudges',
    value: 9,
    unit: 'tips',
    trend: -4,
    description: 'Try enabling auto-reminder for long trips to boost this stat.',
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

final journeyMoments = <JourneyMoment>[
  JourneyMoment(
    id: 'moment-1',
    title: 'Sunrise Autonomous Transfer',
    subtitle: 'Edgewater ➜ Brickell rooftop pad',
    imageUrl:
        'https://images.unsplash.com/photo-1469478715127-7c631389bc21?auto=format&fit=crop&w=1400&q=80',
    metricLabel: 'CO₂ saved',
    metricValue: '3.4kg',
    storySegments: const [
      'Pre-heated cabin ready at 05:20',
      'Nex-AI rerouted away from port congestion',
      'Shared playlist synced with co-rider',
    ],
    accentColor: const Color(0xFF47E7FF),
  ),
  JourneyMoment(
    id: 'moment-2',
    title: 'Art Week Concierge',
    subtitle: 'Wynwood studio loop',
    imageUrl:
        'https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1400&q=80',
    metricLabel: 'Studios visited',
    metricValue: '6 stops',
    storySegments: const [
      'Vehicle transformed interior lighting to gallery preset',
      'One tap share links for each curator drop',
      'Adaptive suspension cushioned cobblestone alleys',
    ],
    accentColor: const Color(0xFFFF6FD8),
  ),
  JourneyMoment(
    id: 'moment-3',
    title: 'Weekend Island Hop',
    subtitle: 'Downtown ➜ Key Biscayne',
    imageUrl:
        'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1400&q=80',
    metricLabel: 'Range used',
    metricValue: '41 km',
    storySegments: const [
      'Lounge seats flipped to face the ocean',
      'Kids mode engaged with holographic travel quiz',
      'Return trip scheduled automatically after brunch',
    ],
    accentColor: const Color(0xFF22C55E),
  ),
];

final communityChallenges = <CommunityChallenge>[
  const CommunityChallenge(
    id: 'challenge-1',
    title: 'Glassmorphic Pioneer',
    description: 'Complete 5 immersive rides with AI ambient lighting enabled.',
    progress: 3,
    target: 5,
    reward: '+300 XP + holographic badge',
    tagline: '2 rides left to unlock the pioneer capsule.',
  ),
  const CommunityChallenge(
    id: 'challenge-2',
    title: 'Eco Loop Collective',
    description: 'Join fellow riders in offsetting 50km of trips this week.',
    progress: 37,
    target: 50,
    reward: 'Tree planting credit',
    tagline: 'Crew progress updated hourly.',
  ),
  const CommunityChallenge(
    id: 'challenge-3',
    title: 'Night Pulse Defender',
    description: 'Keep 3 late rides rated 5 stars for safety & comfort.',
    progress: 2,
    target: 3,
    reward: 'Priority dispatch next Friday',
    tagline: 'Invite trusted contacts for bonus points.',
  ),
];

final ecoRewards = <EcoReward>[
  EcoReward(
    id: 'eco-1',
    title: 'Aurora tier',
    description: 'Maintain all-electric rides for 10 consecutive days.',
    progress: 0.6,
    streak: 6,
    reward: '+600 glow miles',
    imageUrl:
        'https://images.unsplash.com/photo-1483721310020-03333e577078?auto=format&fit=crop&w=900&q=80',
    accent: const Color(0xFF47E7FF),
  ),
  EcoReward(
    id: 'eco-2',
    title: 'Gravity tier',
    description: 'Refer three teammates to a shared commute pod.',
    progress: 0.35,
    streak: 2,
    reward: 'Crew capsule unlock',
    imageUrl:
        'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?auto=format&fit=crop&w=900&q=80',
    accent: const Color(0xFFFF6FD8),
  ),
  EcoReward(
    id: 'eco-3',
    title: 'Nebula tier',
    description: 'Offset 120km via community challenges this month.',
    progress: 0.8,
    streak: 4,
    reward: 'Priority dispatch weekend',
    imageUrl:
        'https://images.unsplash.com/photo-1469478715127-7c631389bc21?auto=format&fit=crop&w=900&q=80',
    accent: const Color(0xFF22C55E),
  ),
];

final routeInsights = <RouteInsight>[
  RouteInsight(
    id: 'insight-1',
    routeName: 'Harbor Airflow',
    pickup: 'Downtown HQ',
    dropoff: 'Seaplane pier',
    recommendedWindow: '06:40 - 07:10',
    congestionLevel: 'Low turbulence',
    co2Saved: '4.3kg saved',
    description:
        'Morning sea breeze keeps traffic light. AI suggests enabling Chill cabin preset for sunrise glare reduction.',
    mapImageUrl:
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',
    tags: const ['Sunrise', 'Eco bonus'],
  ),
  RouteInsight(
    id: 'insight-2',
    routeName: 'Tech Loop',
    pickup: 'Brickell City',
    dropoff: 'Innovation Pier',
    recommendedWindow: '11:20 - 12:05',
    congestionLevel: 'Moderate',
    co2Saved: '2.1kg saved',
    description:
        'Sensors predict a micro-rain burst. Switch to Adaptive canopy mode and queue a productivity soundscape.',
    mapImageUrl:
        'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1200&q=80',
    tags: const ['Focus', 'Weather'],
  ),
  RouteInsight(
    id: 'insight-3',
    routeName: 'Sunset Drift',
    pickup: 'Design District',
    dropoff: 'Key Biscayne',
    recommendedWindow: '18:10 - 18:45',
    congestionLevel: 'High but stable',
    co2Saved: '5.8kg saved',
    description:
        'AR beacons reroute you along the baywalk for skyline views. Expect 6 extra minutes but earn double aura points.',
    mapImageUrl:
        'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80',
    tags: const ['Scenic', 'Bonus points'],
  ),
];

final cabinMoods = <CabinMood>[
  CabinMood(
    id: 'mood-focus',
    title: 'Focus capsule',
    subtitle: 'Noise cancelled, blue glass glow',
    description:
        'The cabin filters chatter, drops the cabin temperature slightly, and syncs a lo-fi playlist so you can finish slides en route.',
    imageUrl:
        'https://images.unsplash.com/photo-1511396275275-4f55b04b0d5b?auto=format&fit=crop&w=1200&q=80',
    gradient: const [Color(0xFF2F6BFF), Color(0xFF47E7FF)],
    badge: 'Deep work mode',
    focusScore: 0.92,
    energyScore: 0.45,
    rituals: const [
      'Blue haze lighting',
      'Adaptive seat incline',
      'Inbox zero nudges',
    ],
  ),
  CabinMood(
    id: 'mood-reset',
    title: 'Reset ritual',
    subtitle: 'Warm sunrise gradient',
    description:
        'Great after late events. Aromatherapy mist plus guided breathing pulses calm the cabin within two minutes.',
    imageUrl:
        'https://images.unsplash.com/photo-1483721310020-03333e577078?auto=format&fit=crop&w=1200&q=80',
    gradient: const [Color(0xFFFF6FD8), Color(0xFFFFA14E)],
    badge: 'Calm streak +1',
    focusScore: 0.55,
    energyScore: 0.78,
    rituals: const [
      'Sunrise wash lighting',
      'Guided breath cues',
      'Calm tea reminder',
    ],
  ),
  CabinMood(
    id: 'mood-celebrate',
    title: 'Celebrate loop',
    subtitle: 'Neon ribbons + bass boost',
    description:
        'Sync playlists with friends, let AI choreograph the cabin beams, and capture highlight clips for Journey Moments.',
    imageUrl:
        'https://images.unsplash.com/photo-1500534314215-6c8c8e9c90f4?auto=format&fit=crop&w=1200&q=80',
    gradient: const [Color(0xFF7B61FF), Color(0xFF47E7FF)],
    badge: 'Crew vibes',
    focusScore: 0.32,
    energyScore: 0.94,
    rituals: const [
      'Shared playlist sync',
      'Panoramic photo cues',
      'Confetti lighting finale',
    ],
  ),
];

final pulseForecasts = <PulseForecast>[
  const PulseForecast(
    id: 'pf-1',
    title: 'Harbor breeze surge',
    summary:
        'Sensors detect a light crosswind at the marina. Expect smoother EV drifts but +3 min staging.',
    mapImageUrl:
        'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?auto=format&fit=crop&w=1200&q=80',
    timeframe: 'Next 20 min',
    impactLevel: 'Mild delay',
    tags: const ['Waterfront', 'Eco bonus'],
    delayMinutes: 3,
    confidence: 0.86,
  ),
  const PulseForecast(
    id: 'pf-2',
    title: 'Stadium exit wave',
    summary:
        'Concert crowd releases at 22:15. AI suggests sliding pickups 12 min to skip the surge.',
    mapImageUrl:
        'https://images.unsplash.com/photo-1469478715127-7c631389bc21?auto=format&fit=crop&w=1200&q=80',
    timeframe: 'Tonight 22:00',
    impactLevel: 'Heavy congestion',
    tags: const ['Event', 'Night'],
    delayMinutes: 12,
    confidence: 0.74,
  ),
  const PulseForecast(
    id: 'pf-3',
    title: 'Causeway cooling window',
    summary:
        'Ocean mist lowers temps along the causeway. Batteries stay happy; unlock +5% range.',
    mapImageUrl:
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',
    timeframe: 'Tomorrow 05:30',
    impactLevel: 'Advantage',
    tags: const ['Early', 'Range'],
    delayMinutes: -5,
    confidence: 0.9,
  ),
];

final rideJournalEntries = <RideJournalEntry>[
  RideJournalEntry(
    id: 'journal-1',
    title: 'Sunrise deck drop-off',
    route: 'Brickell → Biscayne Harbor',
    mood: 'Focused + calm',
    note:
        'Reviewed tomorrow\'s sprint deck while the cabin dimmed to glacier blue. Driver synced breathing cues to traffic lights.',
    vehicle: 'Lumine Halo X',
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    rating: 4.9,
    tags: const ['Focus', 'Work', 'EV'],
    highlights: const [
      'Inbox zero prompt',
      'Adaptive seat memory saved',
      'Shared deck exported to teammates',
    ],
    accent: const Color(0xFF47E7FF),
  ),
  RideJournalEntry(
    id: 'journal-2',
    title: 'Crew night pulse',
    route: 'Wynwood → Little Havana',
    mood: 'Celebratory energy',
    note:
        'Cabin mood synced to friends playlist. AI captured highlight loop + added auto-caption to Journey Moments.',
    vehicle: 'Aero Pulse GT',
    timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    rating: 5,
    tags: const ['Crew', 'Night', 'Celebration'],
    highlights: const [
      'Neon confetti finale',
      'Shared playlist collab',
      'Bonus aura streak unlocked',
    ],
    accent: const Color(0xFFFF6FD8),
  ),
  RideJournalEntry(
    id: 'journal-3',
    title: 'Sunday recharge loop',
    route: 'Coral Gables → South Pointe',
    mood: 'Recovery + warmth',
    note:
        'Wellness ritual engaged aromatherapy plus warm light pulses. Ended ride with guided stretch reminders and hydration nudge.',
    vehicle: 'Cobalt Summit Max',
    timestamp: DateTime.now().subtract(const Duration(days: 3)),
    rating: 4.7,
    tags: const ['Wellness', 'Slow', 'Family'],
    highlights: const [
      'Breathing cues saved to journal',
      'Hydration reminder scheduled',
      'Driver added scenic detour',
    ],
    accent: const Color(0xFF2F6BFF),
  ),
];

final fleetUpdates = <FleetUpdate>[
  FleetUpdate(
    id: 'fleet-1',
    title: 'Aurora Pods arrive',
    subtitle: 'Adaptive lounge interiors',
    description:
        'Twelve-seat Aurora Pods start piloting downtown this month. Expect swivel work lounges, holo whiteboards, and per-seat climate bubbles.',
    imageUrl:
        'https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1200&q=80',
    status: 'Piloting now',
    eta: 'Wave 1 • Oct 12',
    chips: const ['Workspace', '12 seats', 'Beta'],
    gradient: const [Color(0xFF2F6BFF), Color(0xFF47E7FF)],
  ),
  FleetUpdate(
    id: 'fleet-2',
    title: 'Solstice micro-cars',
    subtitle: 'Nano footprint for dense cores',
    description:
        'Two-seat autonomous pods with sliding doors designed for heritage alleys. Includes curb-friendly wheels + solar skins.',
    imageUrl:
        'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&w=1200&q=80',
    status: 'Design freeze',
    eta: 'Wave 2 • Nov 05',
    chips: const ['2 seats', 'Solar', 'Auto'],
    gradient: const [Color(0xFFFF6FD8), Color(0xFFFFA14E)],
  ),
  FleetUpdate(
    id: 'fleet-3',
    title: 'Glide cargo vans',
    subtitle: 'Creator + crew ready',
    description:
        'Cargo-ready vans refitted with modular walls. Perfect for moving pop-up studios, stage gear, or wellness events.',
    imageUrl:
        'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80',
    status: 'Tooling underway',
    eta: 'Wave 3 • Dec 14',
    chips: const ['Cargo', 'Modular', 'Events'],
    gradient: const [Color(0xFF22C55E), Color(0xFF7B61FF)],
  ),
];
