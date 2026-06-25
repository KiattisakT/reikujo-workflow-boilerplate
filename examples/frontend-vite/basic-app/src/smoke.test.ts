import { describe, expect, it } from 'vitest'

import ExampleService from './services/example'

describe('basic app example', () => {
  it('filters example service items', async () => {
    const result = await ExampleService.list({ search: 'plan' })

    expect(result.total).toBe(1)
    expect(result.items[0]?.title).toContain('plan')
  })
})
