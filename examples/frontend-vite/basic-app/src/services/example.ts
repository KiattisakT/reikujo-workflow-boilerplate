import type { IExampleListPayload, IExampleListResponse } from '@/types/example'

const exampleItems: IExampleListResponse = {
  items: [
    { id: 'example-1', title: 'Explore project reality', status: 'done' },
    { id: 'example-2', title: 'Write scoped plan', status: 'ready' },
    { id: 'example-3', title: 'Run validation before handoff', status: 'blocked' },
  ],
  total: 3,
}

export default class ExampleService {
  /**
   * Get example workflow items.
   */
  static async list(payload: IExampleListPayload = {}): Promise<IExampleListResponse> {
    const search = payload.search?.trim().toLowerCase()

    if (!search) {
      return exampleItems
    }

    const items = exampleItems.items.filter((item) => item.title.toLowerCase().includes(search))

    return {
      items,
      total: items.length,
    }
  }
}
