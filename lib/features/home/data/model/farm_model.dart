class StageMinMax {
  final double? humidityMin;
  final double? humidityMax;
  final double? nitrogenMin;
  final double? nitrogenMax;
  final double? phosphorusMin;
  final double? phosphorusMax;
  final double? potassiumMin;
  final double? potassiumMax;

  StageMinMax({
    this.humidityMin,
    this.humidityMax,
    this.nitrogenMin,
    this.nitrogenMax,
    this.phosphorusMin,
    this.phosphorusMax,
    this.potassiumMin,
    this.potassiumMax,
  });

  factory StageMinMax.fromJson(Map<String, dynamic>? json) {
    return StageMinMax(
      humidityMin: json?['soil_humidity']?['min']?.toDouble(),
      humidityMax: json?['soil_humidity']?['max']?.toDouble(),
      nitrogenMin: json?['nitrogen']?['min']?.toDouble(),
      nitrogenMax: json?['nitrogen']?['max']?.toDouble(),
      phosphorusMin: json?['phosphorus']?['min']?.toDouble(),
      phosphorusMax: json?['phosphorus']?['max']?.toDouble(),
      potassiumMin: json?['potassium']?['min']?.toDouble(),
      potassiumMax: json?['potassium']?['max']?.toDouble(),
    );
  }
}

class SensorData {
  final double? nitrogen;
  final double? phosphorus;
  final double? potassium;
  final double? soilHumidity;
  final double? temperature;
  final double? humidity;
  final DateTime? recordedAt;

  SensorData({
    this.nitrogen,
    this.phosphorus,
    this.potassium,
    this.soilHumidity,
    this.temperature,
    this.humidity,
    this.recordedAt,
  });

  factory SensorData.fromJson(Map<String, dynamic>? json) {
    return SensorData(
      nitrogen: json?['nitrogen']?.toDouble(),
      phosphorus: json?['phosphorus']?.toDouble(),
      potassium: json?['potassium']?.toDouble(),
      soilHumidity: json?['soil_humidity']?.toDouble(),
      temperature: json?['temperature']?.toDouble(),
      humidity: json?['humidity']?.toDouble(),
      recordedAt: DateTime.tryParse(json?['recorded_at'] ?? ''),
    );
  }
}

class SectorData {
  final int? sectorInternalId;
  final int? sectorNumber;
  final String? currentStage;
  final StageMinMax? stageMinMax;
  final SensorData? sensorData;

  SectorData({
    this.sectorInternalId,
    this.sectorNumber,
    this.currentStage,
    this.stageMinMax,
    this.sensorData,
  });

  factory SectorData.fromJson(Map<String, dynamic>? json) {
    return SectorData(
      sectorInternalId: json?['sector_internal_id'],
      sectorNumber: json?['sector_number'],
      currentStage: json?['current_stage'],
      stageMinMax: StageMinMax.fromJson(json?['stage_min_max']),
      sensorData: SensorData.fromJson(json?['sensor_data']),
    );
  }
}
