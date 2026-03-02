import type { Timestamp } from 'firebase-admin/firestore';

export interface UserPreferences {
  notificationsEnabled?: boolean;
  nudgeDaysThreshold?: number;
  friendAccountabilityEnabled?: boolean;
  friendEmails?: string[];
  timezone?: string;
}

export interface UserDoc {
  displayName?: string;
  email?: string;
  disabled?: boolean;
  isAdmin?: boolean;
  experimentCount?: number;
  preferences?: UserPreferences;
}

export interface ExperimentDoc {
  userId?: string;
  name?: string;
  startDate?: Timestamp;
  status?: string;
}

export interface DeviceDoc {
  token?: string;
  notificationsEnabled?: boolean;
}

export interface StatsDoc {
  totalUsers?: number;
  totalExperiments?: number;
  totalCheckins?: number;
  updatedAt?: Timestamp;
}
