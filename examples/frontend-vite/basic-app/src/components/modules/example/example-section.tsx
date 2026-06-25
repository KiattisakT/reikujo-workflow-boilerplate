import type { ComponentProps } from 'react'

import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { cn } from '@/lib/utils'

interface IExampleSectionProps extends ComponentProps<'section'> {}

const ExampleSection = ({ className, ...props }: IExampleSectionProps) => {
  // _Event
  const handleStart = () => {
    // Replace with owner-local behavior when a real module owns this section.
  }

  return (
    <section className={cn('mx-auto grid w-full max-w-3xl gap-4 p-4', className)} {...props}>
      <Card>
        <CardHeader>
          <CardTitle>Example module</CardTitle>
          <CardDescription>
            A module component composes UI primitives and owns screen-specific behavior.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <Button onClick={handleStart}>Start workflow</Button>
        </CardContent>
      </Card>
    </section>
  )
}

export { ExampleSection, type IExampleSectionProps }
