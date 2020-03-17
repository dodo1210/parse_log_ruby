require 'json'

file = File.read('qgames.log')

class Task1
    def endGame(players,total_kills,n_kill,n_killed,games)
        players = players.uniq
        score = Hash.new(0)
        
        n_kill.delete('<world>')
        n_kill.each { |name| score[name] += 1 }
        n_killed.each { |name| score[name] -= 1 }

        r = {}
        r[:total_kills] = total_kills
        r[:players] = players
        r[:kills] = score 
        result = r
        return result       
    end

    def eachN_kill(f)
        return f.split(':')[3].split(' killed')[0].split('\\')[0].strip()
    end

    def eachN_killed(f)
        return f.split('killed ')[1].split(' by')[0].split('\\')[0]
    end

    def task1(file)
        
        all = {}
        game = []
        players = []
        total_kills = 0
        n_kill = []
        n_killed = []
        games = 1

        file.each_line do |f|
            if f.include? "killed"
                game.append(f)
                n_kill.append(eachN_kill(f))
                n_killed.append(eachN_killed(f))
                total_kills+=1
            end

            if f.include? "ClientUserinfoChanged"
                players.append(f.split('n\\')[1].split('t\\')[0].split('\\')[0])
            end
            
            if f.include? "InitGame"
                name = "game_#{games}"
                all[name]=endGame(players,total_kills,n_kill,n_killed,games)
                games+=1
                players = []
                n_kill = []
                n_killed = []
                game = []
                total_kills = 0
            end
        end
        all
    end
end

class Task2
    def task2(score)
        puts(score)
    end
end

class Bonus
    def bonus(file)
        death = []
        cause_death = "MOD_UNKNOWN,MOD_SHOTGUN,MOD_GAUNTLET,MOD_MACHINEGUN,MOD_GRENADE,MOD_GRENADE_SPLASH,MOD_ROCKET,MOD_ROCKET_SPLASH,MOD_PLASMA,MOD_PLASMA_SPLASH,MOD_RAILGUN,MOD_LIGHTNING,MOD_BFG,MOD_BFG_SPLASH,MOD_WATER,MOD_SLIME,MOD_LAVA,MOD_CRUSH,MOD_TELEFRAG,MOD_FALLING,MOD_SUICIDE,MOD_TARGET_LASER,MOD_TRIGGER_HURT,MOD_NAIL,MOD_CHAINGUN,MOD_PROXIMITY_MINE,MOD_KAMIKAZE,MOD_JUICED,MOD_GRAPPLE"
        all = {}
        game = 0

        file.each_line do |f|
            
            if f.include? "killed"
                name = f.split('by ')[1].gsub(/[\n]/,'')
                cause_death.split(',').each do |cs|                   
                    if cs.include? name
                        death.append(name)
                    end
                end
            end

            if f.include? "InitGame"
                game+=1
                score = Hash.new(0)
                name = "game_#{game}"
                death.each { |name| score[name] += 1 }
                all[name] = score
                death = []
            end
        end
        all
    end
end

t = Task1.new
score = t.task1(file)

t2 = Task2.new
t2.task2(score)

b = Bonus.new
puts(b.bonus(file))