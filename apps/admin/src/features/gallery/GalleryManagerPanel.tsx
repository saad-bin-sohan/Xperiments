import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  getDocs,
  limit,
  orderBy,
  query,
  serverTimestamp,
  startAfter,
  updateDoc,
  type DocumentData,
  type QueryDocumentSnapshot,
} from 'firebase/firestore';
import { useEffect, useMemo, useState } from 'react';
import { firestore } from '../../core/firebase';
import type { GalleryTemplate, GalleryTemplateDraft } from '../../core/types';
import { ErrorBlock, LoadingBlock, EmptyBlock } from '../../components/StateBlocks';
import { SectionCard } from '../../components/SectionCard';

const PAGE_SIZE = 25;
const CATEGORIES = ['Challenge', 'Creativity', 'Finance', 'Health', 'Minimalism'] as const;

type DurationUnit = 'days' | 'weeks' | 'months';
type Frequency = 'daily' | 'weekly' | 'custom';

const DEFAULT_DRAFT: GalleryTemplateDraft = {
  name: '',
  category: CATEGORIES[0],
  description: '',
  iconId: 'science_outlined',
  durationValue: 30,
  durationUnit: 'days',
  frequency: 'daily',
  hypothesis: '',
  isFeatured: false,
  featuredOrder: null,
};

function toTemplate(docSnap: QueryDocumentSnapshot<DocumentData>): GalleryTemplate {
  const data = docSnap.data();
  return {
    id: docSnap.id,
    name: String(data.name ?? ''),
    category: String(data.category ?? ''),
    description: String(data.description ?? ''),
    iconId: String(data.iconId ?? ''),
    durationValue: Number(data.durationValue ?? 0),
    durationUnit: String(data.durationUnit ?? 'days'),
    frequency: String(data.frequency ?? 'daily'),
    hypothesis: String(data.hypothesis ?? ''),
    isFeatured: data.isFeatured === true,
    featuredOrder: data.featuredOrder == null ? null : Number(data.featuredOrder),
    createdAt: data.createdAt ?? null,
  };
}

export function GalleryManagerPanel() {
  const [items, setItems] = useState<GalleryTemplate[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [deletingId, setDeletingId] = useState<string | null>(null);

  const [draft, setDraft] = useState<GalleryTemplateDraft>(DEFAULT_DRAFT);
  const [editingId, setEditingId] = useState<string | null>(null);

  const [pageIndex, setPageIndex] = useState(0);
  const [cursors, setCursors] = useState<Array<QueryDocumentSnapshot<DocumentData> | null>>([null]);
  const [hasNextPage, setHasNextPage] = useState(false);

  const collectionRef = useMemo(() => collection(firestore, 'gallery'), []);

  const loadPage = async (index: number) => {
    setLoading(true);
    setError(null);

    try {
      let baseQuery = query(collectionRef, orderBy('createdAt', 'desc'), limit(PAGE_SIZE + 1));
      const cursor = cursors[index];
      if (cursor) {
        baseQuery = query(collectionRef, orderBy('createdAt', 'desc'), startAfter(cursor), limit(PAGE_SIZE + 1));
      }

      const snapshot = await getDocs(baseQuery);
      const hasExtra = snapshot.docs.length > PAGE_SIZE;
      const pageDocs = hasExtra ? snapshot.docs.slice(0, PAGE_SIZE) : snapshot.docs;
      setHasNextPage(hasExtra);
      setItems(pageDocs.map(toTemplate));

      if (hasExtra && pageDocs.length > 0) {
        const nextCursor = pageDocs[pageDocs.length - 1];
        setCursors((prev) => {
          const next = [...prev];
          next[index + 1] = nextCursor;
          return next;
        });
      }

      setPageIndex(index);
    } catch (loadError) {
      setError(loadError instanceof Error ? loadError.message : 'Failed to load templates.');
      setItems([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    void loadPage(0);
  }, []);

  const resetEditor = () => {
    setEditingId(null);
    setDraft(DEFAULT_DRAFT);
  };

  const startEdit = (item: GalleryTemplate) => {
    setEditingId(item.id);
    setDraft({
      name: item.name,
      category: item.category,
      description: item.description,
      iconId: item.iconId,
      durationValue: item.durationValue,
      durationUnit: item.durationUnit,
      frequency: item.frequency,
      hypothesis: item.hypothesis,
      isFeatured: item.isFeatured,
      featuredOrder: item.featuredOrder,
    });
  };

  const saveTemplate = async () => {
    if (saving) {
      return;
    }

    if (!draft.name.trim() || !draft.description.trim() || !draft.hypothesis.trim()) {
      setError('Name, description, and hypothesis are required.');
      return;
    }

    setSaving(true);
    setError(null);

    const payload = {
      name: draft.name.trim(),
      category: draft.category,
      description: draft.description.trim(),
      iconId: draft.iconId.trim(),
      durationValue: draft.durationValue,
      durationUnit: draft.durationUnit,
      frequency: draft.frequency,
      hypothesis: draft.hypothesis.trim(),
      isFeatured: draft.isFeatured,
      featuredOrder: draft.isFeatured ? draft.featuredOrder : null,
    };

    try {
      if (editingId) {
        await updateDoc(doc(firestore, 'gallery', editingId), payload);
      } else {
        await addDoc(collectionRef, {
          ...payload,
          createdAt: serverTimestamp(),
        });
      }

      resetEditor();
      await loadPage(pageIndex);
    } catch (saveError) {
      setError(saveError instanceof Error ? saveError.message : 'Failed to save template.');
    } finally {
      setSaving(false);
    }
  };

  const deleteTemplate = async (id: string) => {
    if (deletingId) {
      return;
    }

    const confirmed = window.confirm('Delete this gallery template?');
    if (!confirmed) {
      return;
    }

    setDeletingId(id);
    setError(null);

    try {
      await deleteDoc(doc(firestore, 'gallery', id));
      if (editingId === id) {
        resetEditor();
      }
      await loadPage(pageIndex);
    } catch (deleteError) {
      setError(deleteError instanceof Error ? deleteError.message : 'Failed to delete template.');
    } finally {
      setDeletingId(null);
    }
  };

  return (
    <SectionCard
      title="Gallery Manager"
      subtitle="Create, edit, delete, and feature experiment templates."
      actions={
        <button type="button" onClick={resetEditor}>
          New Template
        </button>
      }
    >
      {error ? <ErrorBlock message={error} /> : null}
      <div className="split-grid">
        <div>
          {loading ? <LoadingBlock message="Loading gallery templates..." /> : null}
          {!loading && items.length === 0 ? <EmptyBlock message="No templates found." /> : null}
          {!loading && items.length > 0 ? (
            <div className="table-wrap">
              <table>
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Featured</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {items.map((item) => (
                    <tr key={item.id}>
                      <td>{item.name}</td>
                      <td>{item.category}</td>
                      <td>{item.isFeatured ? `Yes${item.featuredOrder != null ? ` (#${item.featuredOrder})` : ''}` : 'No'}</td>
                      <td>
                        <div className="row-actions">
                          <button type="button" onClick={() => startEdit(item)}>
                            Edit
                          </button>
                          <button
                            type="button"
                            className="danger"
                            onClick={() => {
                              void deleteTemplate(item.id);
                            }}
                            disabled={deletingId === item.id}
                          >
                            {deletingId === item.id ? 'Deleting...' : 'Delete'}
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ) : null}
          <div className="pagination-row">
            <button
              type="button"
              disabled={pageIndex === 0 || loading}
              onClick={() => {
                void loadPage(pageIndex - 1);
              }}
            >
              Previous
            </button>
            <span className="muted">Page {pageIndex + 1}</span>
            <button
              type="button"
              disabled={!hasNextPage || loading}
              onClick={() => {
                void loadPage(pageIndex + 1);
              }}
            >
              Next
            </button>
          </div>
        </div>

        <div className="editor-pane">
          <h3>{editingId ? 'Edit Template' : 'New Template'}</h3>
          <label>
            Name
            <input
              value={draft.name}
              onChange={(event) => setDraft((prev) => ({ ...prev, name: event.target.value }))}
            />
          </label>
          <label>
            Category
            <select
              value={draft.category}
              onChange={(event) => setDraft((prev) => ({ ...prev, category: event.target.value }))}
            >
              {CATEGORIES.map((category) => (
                <option key={category} value={category}>
                  {category}
                </option>
              ))}
            </select>
          </label>
          <label>
            Description
            <textarea
              value={draft.description}
              onChange={(event) => setDraft((prev) => ({ ...prev, description: event.target.value }))}
              rows={3}
            />
          </label>
          <label>
            Icon ID
            <input
              value={draft.iconId}
              onChange={(event) => setDraft((prev) => ({ ...prev, iconId: event.target.value }))}
            />
          </label>
          <div className="inline-grid">
            <label>
              Duration Value
              <input
                type="number"
                min={1}
                value={draft.durationValue}
                onChange={(event) =>
                  setDraft((prev) => ({
                    ...prev,
                    durationValue: Number(event.target.value) || 1,
                  }))
                }
              />
            </label>
            <label>
              Duration Unit
              <select
                value={draft.durationUnit}
                onChange={(event) =>
                  setDraft((prev) => ({ ...prev, durationUnit: event.target.value as DurationUnit }))
                }
              >
                <option value="days">Days</option>
                <option value="weeks">Weeks</option>
                <option value="months">Months</option>
              </select>
            </label>
          </div>
          <label>
            Frequency
            <select
              value={draft.frequency}
              onChange={(event) =>
                setDraft((prev) => ({ ...prev, frequency: event.target.value as Frequency }))
              }
            >
              <option value="daily">Daily</option>
              <option value="weekly">Weekly</option>
              <option value="custom">Custom</option>
            </select>
          </label>
          <label>
            Hypothesis
            <textarea
              value={draft.hypothesis}
              onChange={(event) => setDraft((prev) => ({ ...prev, hypothesis: event.target.value }))}
              rows={3}
            />
          </label>
          <label className="checkbox-row">
            <input
              type="checkbox"
              checked={draft.isFeatured}
              onChange={(event) => setDraft((prev) => ({ ...prev, isFeatured: event.target.checked }))}
            />
            Featured
          </label>
          {draft.isFeatured ? (
            <label>
              Featured Order
              <input
                type="number"
                min={1}
                value={draft.featuredOrder ?? ''}
                onChange={(event) => {
                  const value = event.target.value;
                  setDraft((prev) => ({
                    ...prev,
                    featuredOrder: value.trim().length === 0 ? null : Number(value),
                  }));
                }}
              />
            </label>
          ) : null}
          <div className="row-actions">
            <button type="button" onClick={() => void saveTemplate()} disabled={saving}>
              {saving ? 'Saving...' : editingId ? 'Save Changes' : 'Create Template'}
            </button>
            {editingId ? (
              <button type="button" onClick={resetEditor}>
                Cancel
              </button>
            ) : null}
          </div>
        </div>
      </div>
    </SectionCard>
  );
}
