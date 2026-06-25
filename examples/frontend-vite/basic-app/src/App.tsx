import { useEffect, useMemo, useState } from 'react'

import { ExampleListState } from '@/components/modules/example'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Separator } from '@/components/ui/separator'
import { Textarea } from '@/components/ui/textarea'
import { useExampleToggle } from '@/hooks/use-example-toggle'
import ExampleService from '@/services/example'
import type { IExampleItem } from '@/types/example'

const App = () => {
  const notes = useExampleToggle(false)

  // _State
  const [items, setItems] = useState<IExampleItem[]>([])
  const [search, setSearch] = useState('')
  const [state, setState] = useState<'loading' | 'data' | 'empty' | 'error'>('loading')

  // _Memo
  const visibleItems = useMemo(() => {
    if (state === 'empty') {
      return []
    }

    return items
  }, [items, state])

  // _Effect
  useEffect(() => {
    let isActive = true

    const loadItems = async () => {
      setState('loading')
      const result = await ExampleService.list({ search })

      if (!isActive) {
        return
      }

      setItems(result.items)
      setState(result.items.length > 0 ? 'data' : 'empty')
    }

    void loadItems()

    return () => {
      isActive = false
    }
  }, [search])

  return (
    <main className="mx-auto grid min-h-dvh w-full max-w-6xl gap-6 px-4 py-10 md:grid-cols-[0.92fr_1.08fr] md:px-8">
      <section className="grid content-start gap-6">
        <div className="grid gap-3">
          <Badge variant="outline">Runnable example</Badge>
          <h1 className="max-w-xl text-4xl font-semibold tracking-tight md:text-6xl">
            Reikujo frontend-vite basic app
          </h1>
          <p className="max-w-2xl text-muted-foreground">
            A small runnable example that composes the generated primitives, service template, hook template, and query-state example.
          </p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Project intake</CardTitle>
            <CardDescription>Form controls use explicit labels and helper copy.</CardDescription>
          </CardHeader>
          <CardContent className="grid gap-4">
            <div className="grid gap-2">
              <Label htmlFor="project-name">Project name</Label>
              <Input id="project-name" defaultValue="Pocket Ledger" />
              <p className="text-sm text-muted-foreground">Use the real product name, not a placeholder.</p>
            </div>

            <div className="grid gap-2">
              <Label htmlFor="project-notes">Notes</Label>
              <Textarea id="project-notes" placeholder="What should the next agent know?" />
            </div>

            <Separator />

            <div className="flex flex-wrap gap-2">
              <Button onClick={notes.toggle}>{notes.isOpen ? 'Hide notes' : 'Show notes'}</Button>
              <Button variant="outline" onClick={() => setState('error')}>
                Preview error
              </Button>
              <Button variant="ghost" onClick={() => setSearch('missing')}>
                Preview empty
              </Button>
            </div>
          </CardContent>
        </Card>

        {notes.isOpen ? (
          <Card>
            <CardHeader>
              <CardTitle>Pattern notes</CardTitle>
              <CardDescription>What this example is meant to prove.</CardDescription>
            </CardHeader>
            <CardContent className="grid gap-2 text-sm text-muted-foreground">
              <p>Base primitives stay generic in components/ui.</p>
              <p>Module components own product state presentation.</p>
              <p>Services own data access and payload mapping.</p>
            </CardContent>
          </Card>
        ) : null}
      </section>

      <section className="grid content-start gap-4">
        <Card>
          <CardHeader>
            <CardTitle>Workflow search</CardTitle>
            <CardDescription>Search runs through ExampleService and renders via ExampleListState.</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="grid gap-2">
              <Label htmlFor="workflow-search">Filter items</Label>
              <Input
                id="workflow-search"
                value={search}
                onChange={(event) => setSearch(event.target.value)}
                placeholder="Try plan or validation"
              />
            </div>
          </CardContent>
        </Card>

        <ExampleListState
          items={visibleItems}
          isLoading={state === 'loading'}
          errorMessage={state === 'error' ? 'Could not load workflow items. Try again.' : undefined}
        />
      </section>
    </main>
  )
}

export default App
