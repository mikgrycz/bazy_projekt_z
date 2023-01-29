import { createTRPCReact } from '@trpc/react-query';
import type { AppRouter } from '../../server/trpc/trpc';

export const trpc = createTRPCReact<AppRouter>();