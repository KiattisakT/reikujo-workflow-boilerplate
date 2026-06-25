import type { IExampleItem } from '@/types/example'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Skeleton } from '@/components/ui/skeleton'

interface IExampleListStateProps {
  items: IExampleItem[]
  isLoading?: boolean
  errorMessage?: string
  className?: string
}

const statusLabels: Record<IExampleItem['status'], string> = {
  ready: 'Ready',
  blocked: 'Blocked',
  done: 'Done',
}

const statusVariants: Record<IExampleItem['status'], 'default' | 'destructive' | 'muted'> = {
  ready: 'muted',
  blocked: 'destructive',
  done: 'default',
}

const ExampleListState = ({ items, isLoading, errorMessage, className }: IExampleListStateProps) => {
  if (isLoading) {
    return (
      <Card className={className}>
        <CardHeader>
          <CardTitle>Workflow items</CardTitle>
          <CardDescription>Loading current work.</CardDescription>
        </CardHeader>
        <CardContent className="grid gap-2">
          {Array.from({ length: 3 }).map((_, index) => (
            <Skeleton key={index} className="h-10" />
          ))}
        </CardContent>
      </Card>
    )
  }

  if (errorMessage) {
    return (
      <Card className={className}>
        <CardHeader>
          <CardTitle>Could not load workflow items</CardTitle>
          <CardDescription>{errorMessage}</CardDescription>
        </CardHeader>
        <CardContent>
          <Button variant="outline">Try again</Button>
        </CardContent>
      </Card>
    )
  }

  if (items.length === 0) {
    return (
      <Card className={className}>
        <CardHeader>
          <CardTitle>No workflow items yet</CardTitle>
          <CardDescription>Create a plan or handoff to populate this list.</CardDescription>
        </CardHeader>
      </Card>
    )
  }

  return (
    <Card className={className}>
      <CardHeader>
        <CardTitle>Workflow items</CardTitle>
        <CardDescription>Example loading, empty, error, and data state ownership.</CardDescription>
      </CardHeader>
      <CardContent>
        <ul className="grid gap-2">
          {items.map((item) => (
            <li
              key={item.id}
              className="flex items-center justify-between gap-3 rounded-md border border-border bg-card px-3 py-2"
            >
              <span>{item.title}</span>
              <Badge variant={statusVariants[item.status]}>{statusLabels[item.status]}</Badge>
            </li>
          ))}
        </ul>
      </CardContent>
    </Card>
  )
}

export { ExampleListState, type IExampleListStateProps }
