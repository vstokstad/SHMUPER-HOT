using System.Collections;
using UnityEngine;

[RequireComponent(typeof(PlayerInput), typeof(PlayerMovement), typeof(PlayerBoundaries))]
[RequireComponent(typeof(Rigidbody))]
[RequireComponent(typeof(SphereCollider), typeof(ParticleSystem))]
public class PlayerController : MonoBehaviour {
    [SerializeField] public PlayerData playerData;
    public float killCounter;
    public WeaponPickUpManager weaponPickUpManager;
    private IEnumerator _collisionManagerRoutine;

    private void Awake(){
        killCounter = 0f;
    }

    private void Update(){
        playerData.RechargeTimer();
        if (killCounter > 5f && killCounter < 10f) {
            weaponPickUpManager.SpawnLaser();
        }
        else if (killCounter > 10f && killCounter < 15f) {
            weaponPickUpManager.SpawnMissiles();
        }
    }

    private void OnCollisionEnter(Collision other){
        const string enemy = "Enemy";
        if (!other.collider.CompareTag(enemy)) return;
        StartCoroutine(CollisionManager(other));
    }

    private IEnumerator CollisionManager(Collision other){
        EnemyController enemyController = other.gameObject.GetComponent<EnemyController>();
        Rigidbody enemyBody = other.gameObject.GetComponent<Rigidbody>();

        TakeDamage(PlayerData.health, enemyController.crashDamage);
        Vector2 bounceOffForce = -enemyBody.velocity;
        enemyBody.AddForce(bounceOffForce, ForceMode.Impulse);
        yield return new WaitForSeconds(0.4f);
        enemyController.TakeDamage(playerData.crashDamage);
    }


    static void TakeDamage(float playerHealth, float damage){
        playerHealth -= damage;
        print("took " + damage + " damage. health is now " + playerHealth);
        PlayerData.health = playerHealth;
        if (playerHealth <= 0f) print("DEAD");
    }
}