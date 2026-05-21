import cors from 'cors'
import dotenv from 'dotenv'
import express, { type Express } from 'express'

dotenv.config()

const app: Express = express()
const PORT = process.env.PORT ?? 3001

app.use(
  cors({
    origin: process.env.FRONTEND_URL ?? 'http://localhost:3000',
    credentials: true,
  })
)
app.use(express.json())

// Register your routes here:
// app.use('/api/users', userRoutes)

app.get('/api/health', (_req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() })
})

app.listen(PORT, () => {
  console.info(`Backend running on http://localhost:${PORT}`)
})

export { app }
