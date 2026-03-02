import type { Timestamp } from 'firebase/firestore';

export interface AdminUserRow {
  id: string;
  email: string;
  displayName: string;
  createdAt: Timestamp | null;
  disabled: boolean;
  isAdmin: boolean;
  experimentCount: number;
}

export interface GalleryTemplate {
  id: string;
  name: string;
  category: string;
  description: string;
  iconId: string;
  durationValue: number;
  durationUnit: string;
  frequency: string;
  hypothesis: string;
  isFeatured: boolean;
  featuredOrder: number | null;
  createdAt: Timestamp | null;
}

export interface GalleryTemplateDraft {
  name: string;
  category: string;
  description: string;
  iconId: string;
  durationValue: number;
  durationUnit: string;
  frequency: string;
  hypothesis: string;
  isFeatured: boolean;
  featuredOrder: number | null;
}

export interface FeatureFlagsState {
  passFailEnabled: boolean;
  loading: boolean;
  error: string | null;
}

export interface BasicStats {
  totalUsers: number;
  totalExperiments: number;
  totalCheckins: number;
  updatedAtIso: string;
}
