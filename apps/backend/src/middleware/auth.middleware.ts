import type { NextFunction, Request, Response } from 'express'

// Extend Express Request to carry the authenticated user
declare global {
  namespace Express {
    interface Request {
      user?: { id: string; email: string }
    }
  }
}

export const requireAuth = (_req: Request, res: Response, next: NextFunction): void => {
  // TODO: validate JWT / Supabase session here
  // Example with Supabase:
  //
  // const token = req.headers.authorization?.replace('Bearer ', '')
  // if (!token) { res.status(401).json({ success: false, error: 'Unauthorized' }); return }
  //
  // const { data: { user }, error } = await supabase.auth.getUser(token)
  // if (error || !user) { res.status(401).json({ success: false, error: 'Unauthorized' }); return }
  //
  // req.user = { id: user.id, email: user.email! }
  // next()

  next() // remove this line once auth is implemented
}
